
class HL7::Message::Segment::SCH < HL7::Message::Segment
  weight 1
  add_field :placement_id, idx: 1
  add_field :filler_id, idx: 2
  add_field :occurence, idx: 3
  add_field :placer_group, idx: 4
  add_field :schedule_id, idx: 5
  add_field :event_reason, idx: 6
  add_field :reason, idx: 7
  add_field :type, idx: 8
  add_field :duration, idx: 9
  add_field :duration_unit, idx: 10
  add_field :timing_quantity, idx: 11
  add_field :placer_name, idx: 12
  add_field :placer_phone_number, idx: 13
  add_field :placer_address, idx: 14
  add_field :placer_location, idx: 15
  add_field :filler_name, idx: 16
  add_field :filler_phone_number, idx: 17
  add_field :filler_address, idx: 18
  add_field :filler_location, idx: 19
  add_field :entered_by_name, idx: 20
  add_field :entered_by_phone_number, idx: 21
  add_field :entered_by_location, idx: 22
  add_field :parent_placement_id, idx: 23
  add_field :parent_filler_id, idx: 24
  add_field :status_code, idx: 25
  add_field :placer_order_number, idx: 26
  add_field :filler_order_number, idx: 27
end
