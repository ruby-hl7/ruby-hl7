
class HL7::Message::Segment::AIG < HL7::Message::Segment
  weight 1
  add_field :set_id, idx: 1
  add_field :action_code, idx: 2
  add_field :id, idx: 3
  add_field :type, idx: 4
  add_field :group, idx: 5
  add_field :quantity, idx: 6
  add_field :quantity_unit, idx: 7
  add_field :start_time, idx: 8
  add_field :start_time_offset, idx: 9
  add_field :start_time_offset_unit, idx: 10
  add_field :duration, idx: 11
  add_field :duration_unit, idx: 12
  add_field :allow_subsitution_code, idx: 13
  add_field :status, idx: 14
end
