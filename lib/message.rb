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
  extend HL7::MessageBatchParser

  attr_reader :message_parser, :element_delim, :item_delim, :segment_delim, :delimiter

  # setup a new hl7 message
  # raw_msg:: is an optional object containing an hl7 message
  #           it can either be a string or an Enumerable object
  def initialize(raw_msg = nil, &blk)
    @segments = []
    @segments_by_name = {}
    @item_delim = "^"
    @element_delim = "|"
    @segment_delim = "\r"
    @delimiter = HL7::Message::Delimiter.new(@element_delim,
      @item_delim,
      @segment_delim)

    @message_parser = HL7::MessageParser.new(@delimiter)

    parse(raw_msg) if raw_msg

    return unless block_given?

    yield self
  end

  def parse(inobj)
    if inobj.is_a?(String)
      generate_segments(message_parser.parse_string(inobj))
    elsif inobj.respond_to?(:each)
      generate_segments_enumerable(inobj)
    else
      raise HL7::ParseError.new("object to parse should be string or enumerable")
    end
  end

  def generate_segments_enumerable(enumerable)
    enumerable.each do |segment|
      generate_segments(message_parser.parse_string(segment.to_s))
    end
  end

  # access a segment of the message
  # index:: can be a Range, Integer or anything that
  #         responds to to_sym
  def [](index)
    ret = nil

    if index.is_a?(Range) || index.is_a?(Integer)
      ret = @segments[index]
    elsif index.respond_to? :to_sym
      ret = @segments_by_name[index.to_sym]
      ret = ret.first if ret && ret.length == 1
    end

    ret
  end

  # modify a segment of the message
  # index:: can be a Range, Integer or anything that
  #         responds to to_sym
  # value:: an HL7::Message::Segment object
  def []=(index, value)
    unless value && value.is_a?(HL7::Message::Segment)
      raise HL7::Exception.new("attempting to assign something other than an HL7 Segment")
    end

    if index.is_a?(Range) || index.is_a?(Integer)
      @segments[index] = value
    elsif index.respond_to?(:to_sym)
      (@segments_by_name[index.to_sym] ||= []) << value
    else
      raise HL7::Exception.new("attempting to use an indice that is not a Range, Integer or to_sym providing object")
    end

    value.segment_parent = self
  end

  # return the index of the value if it exists, nil otherwise
  # value:: is expected to be a string
  def index(value)
    return nil unless value && value.respond_to?(:to_sym)

    segs = @segments_by_name[value.to_sym]
    return nil unless segs

    @segments.index(segs.to_a.first)
  end

  # add a segment or array of segments to the message
  # * will force auto set_id sequencing for segments containing set_id's
  def <<(value)
    # do nothing if value is nil
    return unless value

    if value.is_a? Array
      value.map {|item| append(item) }
    else
      append(value)
    end
  end

  def append(value)
    unless value && value.is_a?(HL7::Message::Segment)
      raise HL7::Exception.new("attempting to append something other than an HL7 Segment")
    end

    value.segment_parent = self unless value.segment_parent
    (@segments ||= []) << value
    name = value.class.to_s.gsub("HL7::Message::Segment::", "").to_sym
    (@segments_by_name[name] ||= []) << value
    sequence_segments unless defined?(@parsing) && @parsing # let's auto-set the set-id as we go
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
    @segments.collect {|s| s if s.to_s.length > 0 }.join("\n")
  end

  # provide a HL7 spec version of the message
  def to_hl7
    @segments.collect {|s| s if s.to_s.length > 0 }.join(@delimiter.segment)
  end

  # provide the HL7 spec version of the message wrapped in MLLP
  def to_mllp
    pre_mllp = to_hl7
    "\x0b" + pre_mllp + "\x1c\r"
  end

  # auto-set the set_id fields of any message segments that
  # provide it and have more than one instance in the message
  def sequence_segments(base = nil)
    last = nil
    segs = @segments
    segs = base.children if base

    segs.each do |s|
      if s.is_a?(last.class) && s.respond_to?(:set_id)
        last.set_id = 1 unless last.set_id && last.set_id.to_i > 0
        s.set_id = last.set_id.to_i + 1
      end

      sequence_segments(s) if s.has_children?

      last = s
    end
  end

  # Checks if any of the results is a correction
  def correction?
    Array(self[:OBX]).any?(&:correction?)
  end

private

  def generate_segments(ary)
    raise HL7::ParseError.new("no array to generate segments") unless ary.length > 0

    @parsing = true
    segment_stack = []
    ary.each do |elm|
      update_delimiters(elm) if elm.slice(0, 3) == "MSH"
      generate_segment(elm, segment_stack)
    end
    @parsing = nil
  end

  def update_delimiters(elm)
    @item_delim = message_parser.parse_item_delim(elm)
    @element_delim = message_parser.parse_element_delim(elm)
    @delimiter.item = @item_delim
    @delimiter.element = @element_delim
  end

  def generate_segment(elm, segment_stack)
    segment_generator = HL7::Message::SegmentGenerator.new(elm,
      segment_stack,
      @delimiter)

    return nil unless segment_generator.valid_segments_parts?

    segment_generator.seg_name = segment_generator.seg_parts[0]

    new_seg = segment_generator.build
    new_seg.segment_parent = self

    choose_segment_from(segment_stack, new_seg, segment_generator.seg_name)
  end

  def choose_segment_from(segment_stack, new_seg, seg_name)
    # Segments have been previously seen
    while segment_stack.length > 0
      if segment_stack.last && segment_stack.last.has_children? && segment_stack.last.accepts?(seg_name)
        # If a previous segment can accept the current segment as a child,
        # add it to the previous segments children
        segment_stack.last.children << new_seg
        new_seg.is_child_segment = true
        segment_stack << new_seg
        break
      else
        segment_stack.pop
      end
    end

    # Root of segment 'tree'
    return unless segment_stack.length == 0

    @segments << new_seg
    segment_stack << new_seg
    setup_segment_lookup_by_name(seg_name, new_seg)
  end

  # Allow segment lookup by name
  def setup_segment_lookup_by_name(seg_name, new_seg)
    seg_sym = get_symbol_from_name(seg_name)
    return unless seg_sym

    @segments_by_name[seg_sym] ||= []
    @segments_by_name[seg_sym] << new_seg
  end

  def get_symbol_from_name(seg_name)
    seg_name.to_s.strip.length > 0 ? seg_name.to_sym : nil
  end
end
