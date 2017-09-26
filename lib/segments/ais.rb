
class HL7::Message::Segment::AIS < HL7::Message::Segment
  weight 1
  add_field :set_id, idx: 1
  add_field :action_code, idx: 2
  add_field :universal_service_identifier, idx: 3
  add_field :start_time, idx: 4
  add_field :start_time_offset, idx: 5
  add_field :start_time_offset_unit, idx: 6
  add_field :duration, idx: 7
  add_field :duration_unit, idx: 8
  add_field :allow_subsitution_code, idx: 9
  add_field :status, idx: 10
  add_field :placer_extended_information, idx: 11
  add_field :filler_extended_information, idx: 12
end
