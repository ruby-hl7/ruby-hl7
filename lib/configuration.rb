class HL7::Configuration
  attr_reader :segments

  def initialize
    @segments = Segments.new
  end

  class Segments
    def add(segment_name, &block)
      segment_class = Class.new(HL7::Message::Segment, &block)
      HL7::Message::Segment.const_set(segment_name, segment_class)
    end

    def update(segment_name, &block)
      HL7::Message::Segment
        .const_get(segment_name)
        .instance_eval(&block)
    end
  end
end
