class HL7::Message::Segment::AIG < HL7::Message::Segment
  weight 1
  add_field :set_id
  add_field :segment_action_code
  add_field :resource_id
  add_field :resource_type
  add_field :resource_group
  add_field :resource_quantity
  add_field :resource_quantity_units
  add_field :start_time
  add_field :start_time_offset
  add_field :start_time_offset_units
  add_field :duration
  add_field :duration_units
  add_field :allow_subsitution_code
  add_field :filler_status_status

  alias_field :start_date, :start_time
  alias_field :start_date_offset, :start_time_offset
  alias_field :start_date_offset_units, :start_time_offset_units
end
