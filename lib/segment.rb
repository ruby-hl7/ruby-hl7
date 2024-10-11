# Ruby Object representation of an hl7 2.x message segment
# The segments can be setup to provide aliases to specific fields with
# optional validation code that is run when the field is modified
# The segment field data is also accessible via the e<number> method.
#
# == Defining a New Segment
#  class HL7::Message::Segment::NK1 < HL7::Message::Segment
#    weight 100 # segments are sorted ascendingly
#    add_field :something_you_want       # assumes :idx=>1
#    add_field :something_else, :idx=>6  # :idx=>6 and field count=6
#    add_field :something_more           # :idx=>7
#    add_field :block_example do |value|
#       raise HL7::InvalidDataError.new
#                                  unless value.to_i < 100 && value.to_i > 10
#      return value
#    end
#    # this block will be executed when seg.block_example= is called
#    # and when seg.block_example is called
#
class HL7::Message::Segment
  extend HL7::Message::SegmentListStorage
  include HL7::Message::SegmentFields

  attr_accessor :segment_parent
  attr_reader :element_delim
  attr_reader :item_delim
  attr_reader :repetition_delim
  attr_reader :segment_weight

  METHOD_MISSING_FOR_INITIALIZER = <<-END
    def method_missing( sym, *args, &blk )
      __seg__.send( sym, args, blk )
    end
  END

  # setup a new HL7::Message::Segment
  # raw_segment:: is an optional String or Array which will be used as the
  #               segment's field data
  # delims:: an optional array of delimiters, where
  #               delims[0] = element delimiter
  #               delims[1] = item delimiter
  #               delims[2] = repetition delimiter
  def initialize(raw_segment="", delims=[], &blk)
    @segments_by_name = {}
    @field_total = 0
    @is_child = false

    setup_delimiters delims

    @elements = elements_from_segment(raw_segment)

    if block_given?
      callctx = eval( "self", blk.binding )
      def callctx.__seg__(val=nil)
        @__seg_val__ ||= val
      end
      callctx.__seg__(self)
      # TODO: find out if this pollutes the calling namespace permanently...

      eval( METHOD_MISSING_FOR_INITIALIZER, blk.binding )
      yield self
      eval( "class << self; remove_method :method_missing;end", blk.binding )
    end
  end

  # Breaks the raw segment into elements
  # raw_segment:: is an optional String or Array which will be used as the
  #               segment's field data
  def elements_from_segment(raw_segment)
    if (raw_segment.kind_of? Array)
      elements = raw_segment
    else
      elements = HL7::MessageParser.split_by_delimiter( raw_segment,
                                                        @element_delim )
      if raw_segment == ""
        elements[0] = self.class.to_s.split( "::" ).last
        elements << ""
      end
    end
    if HL7.configuration.enable_repetitions
      elements[1..]&.each_with_index do |element, index|
        is_msh_encoding_characters_field = elements[0] == 'MSH' && index == 0
        if element.include?(repetition_delim) && !is_msh_encoding_characters_field
          elements[index + 1] = HL7::MessageParser.split_by_delimiter(element, repetition_delim)
        end
      end
    end
    elements
  end

  def to_info
    "%s: empty segment >> %s" % [ self.class.to_s, @elements.inspect ]
  end

  # output the HL7 spec version of the segment
  def to_s
    @elements
      .collect do |element|
        case element
        when Array
          if HL7.configuration.enable_repetitions
            element.join(repetition_delim)
          else
            element
          end
        else
          element
        end
      end
      .join(element_delim)
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
      write_field( base_sym, *args )
    else
      if args.length > 0
        write_field( base_sym, *args.flatten.select { |arg| arg } )
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

  # yield each element in the segment
  def each # :yields: element
    return unless @elements
    @elements.each { |e| yield e }
  end

  # get the length of the segment (number of fields it contains)
  def length
    0 unless @elements
    @elements.length
  end

  def has_children?
    self.respond_to?(:children)
  end

  private
  def self.singleton #:nodoc:
    class << self; self end
  end

  def setup_delimiters(delims)
    delims = [ delims ].flatten

    @element_delim = ( delims.length > 0 ) ? delims[0] : "|"
    @item_delim = ( delims.length > 1 ) ? delims[1] : "^"
    @repetition_delim = ( delims.length > 2 ) ? delims[2] : "~"
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

  def self.convert_to_ts(value) #:nodoc:
    value.respond_to?(:to_hl7) ? value.to_hl7 : value
  end

end
