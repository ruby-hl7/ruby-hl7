
class HL7::Message::Segment::RGS < HL7::Message::Segment
  weight 3
  add_field :set_id, idx: 1
  add_field :action_code, idx: 2
  add_field :resource_group, idx: 3
end
