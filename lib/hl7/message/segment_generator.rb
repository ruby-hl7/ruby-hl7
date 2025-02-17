# frozen_string_literal: true

# Methods for creating segments in Message
class HL7::Message::SegmentGenerator
  attr_reader :element, :last_seg, :delimiter

  attr_accessor :seg_parts, :seg_name

  def initialize(element, last_seg, delimiter)
    @element = element
    @last_seg = last_seg
    @delimiter = delimiter

    @seg_parts = HL7::MessageParser.split_by_delimiter(element,
      delimiter.element)
  end

  def valid_segments_parts?
    return true if @seg_parts&.length&.positive?

    raise HL7::EmptySegmentNotAllowed if HL7.configuration.empty_segment_is_error

    false
  end

  def build
    klass = get_segment_class
    klass.new(@element, [@delimiter.element, @delimiter.item])
  end

  def get_segment_class
    segment_to_search = @seg_name.to_sym
    segment_to_search = @seg_name if RUBY_VERSION < "1.9"

    if HL7::Message::Segment.constants.index(segment_to_search)
      eval(format("HL7::Message::Segment::%s", @seg_name))
    else
      HL7::Message::Segment::Default
    end
  end
end
