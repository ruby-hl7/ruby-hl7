require 'ruby-hl7'
class HL7::Message::Segment::ZCF < HL7::Message::Segment
  weight 1000

  add_field :id
  add_field :ownership
  add_field :value
end
