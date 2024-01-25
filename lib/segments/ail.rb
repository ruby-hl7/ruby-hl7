class HL7::Message::Segment::AIL < HL7::Message::Segment
  weight 0
  add_field :set_id
  add_field :segment_action_code
  add_field :location_resource_id
  add_field :location_type
  add_field :location_group
  add_field :start_date_time
  add_field :start_date_time_offset
  add_field :start_date_time_offset_units
  add_field :duration
  add_field :duration_units
  add_field :allow_substitution_code
  add_field :filler_status_code
end
