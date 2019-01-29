class HL7::Message::Segment::AIS < HL7::Message::Segment
  weight 1
  add_field :set_id
  add_field :segment_action_code
  add_field :universal_service_identifier
  add_field :start_time
  add_field :start_time_offset
  add_field :start_time_offset_units
  add_field :duration
  add_field :duration_units
  add_field :allow_subsitution_code
  add_field :filler_status_code
  add_field :placer_supplemental_service_information
  add_field :filler_supplemental_service_information

  alias_field :start_date, :start_time
  alias_field :start_date_offset, :start_time_offset
  alias_field :start_date_offset_units, :start_time_offset_units
end
