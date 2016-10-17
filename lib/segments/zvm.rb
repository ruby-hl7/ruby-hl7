require 'ruby-hl7'

class HL7::Message::Segment::ZVM < HL7::Message::Segment
  weight 1000

  add_field :visit_motives, idx: 1
end
