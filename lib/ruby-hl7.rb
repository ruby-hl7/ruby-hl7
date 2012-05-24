# encoding: UTF-8
#= ruby-hl7.rb
# Ruby HL7 is designed to provide a simple, easy to use library for
# parsing and generating HL7 (2.x) messages.
#
#
# Author:    Mark Guzman  (mailto:segfault@hasno.info)
#
# Copyright: (c) 2006-2009 Mark Guzman
#
# License:   BSD
#
#  $Id$
#
# == License
# see the LICENSE file
#

require 'rubygems'
require "stringio"
require "date"

module HL7 # :nodoc:
  VERSION = "1.0.3"
  def self.ParserConfig
    @parser_cfg ||= { :empty_segment_is_error => true }
  end
end

# Encapsulate HL7 specific exceptions
class HL7::Exception < StandardError
end

# Parsing failed
class HL7::ParseError < HL7::Exception
end

# Attempting to use an invalid indice
class HL7::RangeError < HL7::Exception
end

# Attempting to assign invalid data to a field
class HL7::InvalidDataError < HL7::Exception
end

# Ruby Object representation of an hl7 2.x message
# the message object is actually a "smart" collection of hl7 segments
# == Examples
#
# ==== Creating a new HL7 message
#
#  # create a message
#  msg = HL7::Message.new
#
#  # create a MSH segment for our new message
#  msh = HL7::Message::Segment::MSH.new
#  msh.recv_app = "ruby hl7"
#  msh.recv_facility = "my office"
#  msh.processing_id = rand(10000).to_s
#
#  msg << msh # add the MSH segment to the message
#
#  puts msg.to_s # readable version of the message
#
#  puts msg.to_hl7 # hl7 version of the message (as a string)
#
#  puts msg.to_mllp # mllp version of the message (as a string)
#
# ==== Parse an existing HL7 message
#
#  raw_input = open( "my_hl7_msg.txt" ).readlines
#  msg = HL7::Message.new( raw_input )
#
#  puts "message type: %s" % msg[:MSH].message_type
#
#
class HL7::Message
  include Enumerable # we treat an hl7 2.x message as a collection of segments
  attr :element_delim
  attr :item_delim
  attr :segment_delim

  # setup a new hl7 message
  # raw_msg:: is an optional object containing an hl7 message
  #           it can either be a string or an Enumerable object
  def initialize( raw_msg=nil, &blk )
    @segments = []
    @segments_by_name = {}
    @item_delim = "^"
    @element_delim = '|'
    @segment_delim = "\r"

    parse( raw_msg ) if raw_msg

    if block_given?
      blk.call self
    end
  end

  # access a segment of the message
  # index:: can be a Range, Fixnum or anything that
  #         responds to to_sym
  def []( index )
    ret = nil

    if index.kind_of?(Range) || index.kind_of?(Fixnum)
      ret = @segments[ index ]
    elsif (index.respond_to? :to_sym)
      ret = @segments_by_name[ index.to_sym ]
      ret = ret.first if ret && ret.length == 1
    end

    ret
  end

  # modify a segment of the message
  # index:: can be a Range, Fixnum or anything that
  #         responds to to_sym
  # value:: an HL7::Message::Segment object
  def []=( index, value )
    unless ( value && value.kind_of?(HL7::Message::Segment) )
      raise HL7::Exception.new( "attempting to assign something other than an HL7 Segment" )
    end

    if index.kind_of?(Range) || index.kind_of?(Fixnum)
      @segments[ index ] = value
    elsif index.respond_to?(:to_sym)
      (@segments_by_name[ index.to_sym ] ||= []) << value
    else
      raise HL7::Exception.new( "attempting to use an indice that is not a Range, Fixnum or to_sym providing object" )
    end

    value.segment_parent = self
  end

  # return the index of the value if it exists, nil otherwise
  # value:: is expected to be a string
  def index( value )
    return nil unless (value && value.respond_to?(:to_sym))

    segs = @segments_by_name[ value.to_sym ]
    return nil unless segs

    @segments.index( segs.to_a.first )
  end

  # add a segment or array of segments to the message
  # * will force auto set_id sequencing for segments containing set_id's
  def <<( value )
    # do nothing if value is nil
    return unless value
    
    if value.kind_of? Array
      value.map{|item| append(item)}
    else
      append(value)
    end
  end

  def append( value )
    unless ( value && value.kind_of?(HL7::Message::Segment) )
      raise HL7::Exception.new( "attempting to append something other than an HL7 Segment" )
    end

    value.segment_parent = self unless value.segment_parent
    (@segments ||= []) << value
    name = value.class.to_s.gsub("HL7::Message::Segment::", "").to_sym
    (@segments_by_name[ name ] ||= []) << value
    sequence_segments unless @parsing # let's auto-set the set-id as we go
  end

  class << self
    def parse_batch(batch) # :yields: message
      raise HL7::ParseError, 'badly_formed_batch_message' unless
        batch.hl7_batch?

      # JRuby seems to change our literal \r characters in sample
      # messages (from here documents) into newlines.  We make a copy
      # here, reverting to carriage returns.  The input is unchanged.
      #
      # This does not occur when posts are received with CR
      # characters, only in sample messages from here documents.  The
      # expensive copy is only incurred when the batch message has a
      # newline character in it.
      batch = batch.gsub("\n", "\r") if batch.include?("\n")

      raise HL7::ParseError, 'empty_batch_message' unless
        match = /\rMSH/.match(batch)

      match.post_match.split(/\rMSH/).each_with_index do |_msg, index|
        if md = /\rBTS/.match(_msg)
          # TODO: Validate the message count in the BTS segment
          # should == index + 1
          _msg = md.pre_match
        end

        yield 'MSH' + _msg
      end
    end

    # parse a String or Enumerable object into an HL7::Message if possible
    # * returns a new HL7::Message if successful
    def parse( inobj )
      HL7::Message.new do |msg|
        msg.parse( inobj )
      end
    end
  end

  # parse the provided String or Enumerable object into this message
  def parse( inobj )
    unless inobj.kind_of?(String) || inobj.respond_to?(:each)
      raise HL7::ParseError.new( "object to parse should be string or enumerable" )
    end

    if inobj.kind_of?(String)
        parse_string( inobj )
    elsif inobj.respond_to?(:each)
        parse_enumerable( inobj )
    end
  end

  # yield each segment in the message
  def each # :yields: segment
    return unless @segments
    @segments.each { |s| yield s }
  end

  # return the segment count
  def length
    0 unless @segments
    @segments.length
  end

  # provide a screen-readable version of the message
  def to_s
    @segments.collect { |s| s if s.to_s.length > 0 }.join( "\n" )
  end

  # provide a HL7 spec version of the message
  def to_hl7
    @segments.collect { |s| s if s.to_s.length > 0 }.join( @segment_delim )
  end

  # provide the HL7 spec version of the message wrapped in MLLP
  def to_mllp
    pre_mllp = to_hl7
    "\x0b" + pre_mllp + "\x1c\r"
  end

  # auto-set the set_id fields of any message segments that
  # provide it and have more than one instance in the message
  def sequence_segments(base=nil)
    last = nil
    segs = @segments
    segs = base.children if base

    segs.each do |s|
      if s.kind_of?( last.class ) && s.respond_to?( :set_id )
        last.set_id = 1 unless last.set_id && last.set_id.to_i > 0
        s.set_id = last.set_id.to_i + 1
      end

      if s.respond_to?(:children)
        sequence_segments( s )
      end

      last = s
    end
  end

  private
  # Get the element delimiter from an MSH segment
  def parse_element_delim(str)
    (str && str.kind_of?(String)) ? str.slice(3,1) : "|"
  end

  # Get the item delimiter from an MSH segment
  def parse_item_delim(str)
    (str && str.kind_of?(String)) ? str.slice(4,1) : "^"
  end

  def parse_enumerable( inary )
    #assumes an enumeration of strings....
    inary.each do |oary|
      parse_string( oary.to_s )
    end
  end

  def parse_string( instr )
    post_mllp = instr
    if /\x0b((:?.|\r|\n)+)\x1c\r/.match( instr )
      post_mllp = $1 #strip the mllp bytes
    end

    ary = post_mllp.split( segment_delim, -1 )
    generate_segments( ary )
  end

  def generate_segments( ary )
    raise HL7::ParseError.new( "no array to generate segments" ) unless ary.length > 0

    @parsing = true
    last_seg = nil
    ary.each do |elm|
      if elm.slice(0,3) == "MSH"
        @item_delim = parse_item_delim(elm)
        @element_delim = parse_element_delim(elm)
      end
      last_seg = generate_segment( elm, last_seg ) || last_seg
    end
    @parsing = nil
  end

  def generate_segment( elm, last_seg )
      seg_parts = elm.split( @element_delim, -1 )
      unless seg_parts && (seg_parts.length > 0)
        raise HL7::ParseError.new( "empty segment is an error per configuration setting" ) if HL7.ParserConfig[:empty_segment_is_error] || false
        return nil
      end

      seg_name = seg_parts[0]
      if RUBY_VERSION < "1.9" && HL7::Message::Segment.constants.index(seg_name) # do we have an implementation?
        kls = eval("HL7::Message::Segment::%s" % seg_name)
      elsif RUBY_VERSION >= "1.9" && HL7::Message::Segment.constants.index(seg_name.to_sym)
        kls = eval("HL7::Message::Segment::%s" % seg_name)
      else
        # we don't have an implementation for this segment
        # so lets just preserve the data
        kls = HL7::Message::Segment::Default
      end
      new_seg = kls.new( elm, [@element_delim, @item_delim] )
      new_seg.segment_parent = self

      if last_seg && last_seg.respond_to?(:children) && last_seg.accepts?( seg_name )
        last_seg.children << new_seg
        new_seg.is_child_segment = true
        return last_seg
      end

      @segments << new_seg

      # we want to allow segment lookup by name
      if seg_name && (seg_name.strip.length > 0)
        seg_sym = seg_name.to_sym
        @segments_by_name[ seg_sym ] ||= []
        @segments_by_name[ seg_sym ] << new_seg
      end

      new_seg
  end
end

# Ruby Object representation of an hl7 2.x message segment
# The segments can be setup to provide aliases to specific fields with
# optional validation code that is run when the field is modified
# The segment field data is also accessible via the e<number> method.
#
# == Defining a New Segment
#  class HL7::Message::Segment::NK1 < HL7::Message::Segment
#    wieght 100 # segments are sorted ascendingly
#    add_field :something_you_want       # assumes :idx=>1
#    add_field :something_else, :idx=>6  # :idx=>6 and field count=6
#    add_field :something_more           # :idx=>7
#    add_field :block_example do |value|
#      raise HL7::InvalidDataError.new unless value.to_i < 100 && value.to_i > 10
#      return value
#    end
#    # this block will be executed when seg.block_example= is called
#    # and when seg.block_example is called
#
class HL7::Message::Segment
  attr :segment_parent, true
  attr :element_delim
  attr :item_delim
  attr :segment_weight

  # setup a new HL7::Message::Segment
  # raw_segment:: is an optional String or Array which will be used as the
  #               segment's field data
  # delims:: an optional array of delimiters, where
  #               delims[0] = element delimiter
  #               delims[1] = item delimiter
  def initialize(raw_segment="", delims=[], &blk)
    @segments_by_name = {}
    @field_total = 0
    @is_child = false

    @element_delim = (delims.kind_of?(Array) && delims.length>0) ? delims[0] : "|"
    @item_delim = (delims.kind_of?(Array) && delims.length>1) ? delims[1] : "^"

    if (raw_segment.kind_of? Array)
      @elements = raw_segment
    else
      @elements = raw_segment.split( @element_delim, -1 )
      if raw_segment == ""
        @elements[0] = self.class.to_s.split( "::" ).last
        @elements << ""
      end
    end

    if block_given?
      callctx = eval( "self", blk.binding )
      def callctx.__seg__(val=nil)
        @__seg_val__ ||= val
      end
      callctx.__seg__(self)
      # TODO: find out if this pollutes the calling namespace permanently...

      to_do = <<-END
      def method_missing( sym, *args, &blk )
        __seg__.send( sym, args, blk )
      end
      END

      eval( to_do, blk.binding )
      yield self
      eval( "undef method_missing", blk.binding )
    end
  end

  def self.add_child_type(child_type)
    if @child_types
      @child_types << child_type.to_sym
    else
      has_children [ child_type.to_sym ]
    end
  end

  def to_info
    "%s: empty segment >> %s" % [ self.class.to_s, @elements.inspect ]
  end

  # output the HL7 spec version of the segment
  def to_s
    @elements.join( @element_delim )
  end

  # at the segment level there is no difference between to_s and to_hl7
  alias :to_hl7 :to_s

  # handle the e<number> field accessor
  # and any aliases that didn't get added to the system automatically
  def method_missing( sym, *args, &blk )
    base_str = sym.to_s.gsub( "=", "" )
    base_sym = base_str.to_sym

    if self.class.fields.include?( base_sym )
      # base_sym is ok, let's move on
    elsif /e([0-9]+)/.match( base_str )
      # base_sym should actually be $1, since we're going by
      # element id number
      base_sym = $1.to_i
    else
      super
    end

    if sym.to_s.include?( "=" )
      write_field( base_sym, args )
    else

      if args.length > 0
        write_field( base_sym, args.flatten.select { |arg| arg } )
      else
        read_field( base_sym )
      end

    end
  end

  # sort-compare two Segments, 0 indicates equality
  def <=>( other )
    return nil unless other.kind_of?(HL7::Message::Segment)

    # per Comparable docs: http://www.ruby-doc.org/core/classes/Comparable.html
    diff = self.weight - other.weight
    return -1 if diff > 0
    return 1 if diff < 0
    return 0
  end

  # get the defined sort-weight of this segment class
  # an alias for self.weight
  def weight
    self.class.weight
  end


  # return true if the segment has a parent
  def is_child_segment?
    (@is_child_segment ||= false)
  end

  # indicate whether or not the segment has a parent
  def is_child_segment=(val)
    @is_child_segment = val
  end

  # get the length of the segment (number of fields it contains)
  def length
    0 unless @elements
    @elements.length
  end


  private
  def self.singleton #:nodoc:
    class << self; self end
  end

  # DSL element to define a segment's sort weight
  # returns the segment's current weight by default
  # segments are sorted ascending
  def self.weight(new_weight=nil)
    if new_weight
      singleton.module_eval do
        @my_weight = new_weight
      end
    end

    singleton.module_eval do
      return 999 unless @my_weight
      @my_weight
    end
  end



  # allows a segment to store other segment objects
  # used to handle associated lists like one OBR to many OBX segments
  def self.has_children(child_types)
    @child_types = child_types
    define_method(:child_types) do
      @child_types
    end

    self.class_eval do
      define_method(:children) do
        unless @my_children
          p = self
          @my_children ||= []
          @my_children.instance_eval do
            @parental = p
            alias :old_append :<<

            def <<( value )
              # do nothing if value is nil
              return unless value
              
              if value.kind_of? Array
                value.map{|item| append(item)}
              else
                append(value)
              end
            end
            
            def append(value)
              unless (value && value.kind_of?(HL7::Message::Segment))
                raise HL7::Exception.new( "attempting to append non-segment to a segment list" )
              end

              value.segment_parent = @parental
              k = @parental
              while (k && k.segment_parent && !k.segment_parent.kind_of?(HL7::Message))
                k = k.segment_parent
              end
              k.segment_parent << value if k && k.segment_parent
              old_append( value )
            end
          end
        end

        @my_children
      end

      define_method('accepts?') do |t|
        t = t.to_sym if t && (t.to_s.length > 0) && t.respond_to?(:to_sym)
        child_types.index t
      end
    end
  end

  # define a field alias
  # * name is the alias itself (required)
  # * options is a hash of parameters
  #   * :id is the field number to reference (optional, auto-increments from 1
  #      by default)
  #   * :blk is a validation proc (optional, overrides the second argument)
  # * blk is an optional validation/convertion proc which MUST take a parameter
  #   and always return a value for the field (it will be used on read/write
  #   calls)
  def self.add_field( name, options={}, &blk )
    options = { :idx =>-1, :blk =>blk}.merge!( options )
    name ||= :id
    namesym = name.to_sym
    @field_cnt ||= 1
    if options[:idx] == -1
      options[:idx] = @field_cnt # provide default auto-incrementing
    end
    @field_cnt = options[:idx].to_i + 1

    singleton.module_eval do
      @fields ||= {}
      @fields[ namesym ] = options
    end

    self.class_eval <<-END
      def #{name}(val=nil)
        unless val
          read_field( :#{namesym} )
        else
          write_field( :#{namesym}, val )
          val # this matches existing n= method functionality
        end
      end

      def #{name}=(value)
        write_field( :#{namesym}, value )
      end
    END
  end

  def self.fields #:nodoc:
    singleton.module_eval do
      (@fields ||= [])
    end
  end

  def self.convert_to_ts(value) #:nodoc:
    if value.is_a?(Time) or value.is_a?(Date)
      return value.to_hl7
    else
      return value
    end
  end

  def field_info( name ) #:nodoc:
    field_blk = nil
    idx = name # assume we've gotten a fixnum
    unless name.kind_of?( Fixnum )
      fld_info = self.class.fields[ name ]
      idx = fld_info[:idx].to_i
      field_blk = fld_info[:blk]
    end

    [ idx, field_blk ]
  end

  def read_field( name ) #:nodoc:
    idx, field_blk = field_info( name )
    return nil unless idx
    return nil if (idx >= @elements.length)

    ret = @elements[ idx ]
    ret = ret.first if (ret.kind_of?(Array) && ret.length == 1)
    ret = field_blk.call( ret ) if field_blk
    ret
  end

  def write_field( name, value ) #:nodoc:
    idx, field_blk = field_info( name )
    return nil unless idx

    if (idx >= @elements.length)
      # make some space for the incoming field, missing items are assumed to
      # be empty, so this is valid per the spec -mg
      missing = ("," * (idx-@elements.length)).split(',',-1)
      @elements += missing
    end

    value = value.first if (value && value.kind_of?(Array) && value.length == 1)
    value = field_blk.call( value ) if field_blk
    @elements[ idx ] = value.to_s
  end

  @elements = []

end

class Date
  # Get a HL7 timestamp (type TS) for a Date instance.
  #
  #  Date.parse('2009-12-02').to_hl7
  #  => "20091202"
  def to_hl7
    strftime('%Y%m%d')
  end
end

class Time
  # Get a HL7 timestamp (type TS) for a Time instance.
  #
  # fraction_digits:: specifies a number of digits of fractional seconds. Its default value is 0.
  #
  #  Time.parse('01:23').to_hl7
  #  => "20091202012300"
  #  Time.now.to_hl7(3)
  #  => "20091202153652.302"
  def to_hl7( fraction_digits = 0)
    strftime('%Y%m%d%H%M%S') +
      if fraction_digits == 0
        ''
      elsif fraction_digits <= 6
        '.' + sprintf('%06d', usec)[0, fraction_digits]
      else
        '.' + sprintf('%06d', usec) + '0' * (fraction_digits - 6)
      end
  end
end

class DateTime
  # Get a HL7 timestamp (type TS) for a Time instance.
  #
  # fraction_digits:: specifies a number of digits of fractional seconds. Its default value is 0.
  #
  #  Time.parse('01:23').to_hl7
  #  => "20091202012300"
  #  Time.now.to_hl7(3)
  #  => "20091202153652.302"
  def to_hl7( fraction_digits = 0)
    strftime('%Y%m%d%H%M%S') +
      if fraction_digits == 0
        ''
      elsif fraction_digits <= 6
        '.' + sprintf('%06d', usec)[0, fraction_digits]
      else
        '.' + sprintf('%06d', usec) + '0' * (fraction_digits - 6)
      end
  end
end

# parse an hl7 formatted date
#def Date.from_hl7( hl7_date )
#end

#def Date.to_hl7_short( ruby_date )
#end

#def Date.to_hl7_med( ruby_date )
#end

#def Date.to_hl7_long( ruby_date )
#end

# Provide a catch-all information preserving segment
# * nb: aliases are not provided BUT you can use the numeric element accessor
#
#  seg = HL7::Message::Segment::Default.new
#  seg.e0 = "NK1"
#  seg.e1 = "SOMETHING ELSE"
#  seg.e2 = "KIN HERE"
#
class HL7::Message::Segment::Default < HL7::Message::Segment
  def initialize(raw_segment="", delims=[])
    segs = [] if (raw_segment == "")
    segs ||= raw_segment
    super( segs, delims )
  end
end

# load our segments
Dir["#{File.dirname(__FILE__)}/segments/*.rb"].each { |ext| load ext }

# vim:tw=78:sw=2:ts=2:et:fdm=marker:
