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
