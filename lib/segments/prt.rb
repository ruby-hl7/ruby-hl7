# frozen_string_literal: true

class HL7::Message::Segment::PRT < HL7::Message::Segment
  add_field :participation_instance_id, :idx => 1
  add_field :action_code, :idx => 2
  add_field :action_reason, :idx => 3
  add_field :participation, :idx => 4
  add_field :participation_person, :idx => 5
  add_field :participation_person_provider_type, :idx => 6
  add_field :participation_organization_unit_type, :idx => 7
  add_field :participation_organization, :idx => 8
  add_field :participation_location, :idx => 9
  add_field :participation_device, :idx => 10
  add_field :participation_begin_date_time, :idx => 11 do |value|
    convert_to_ts(value)
  end
  add_field :participation_end_date_time, :idx => 12 do |value|
    convert_to_ts(value)
  end
  add_field :participation_qualitative_duration, :idx => 13
  add_field :participation_address, :idx => 14
  add_field :participation_telecommunication_address, :idx => 15

  def self.convert_to_ts(value)
    return value.to_hl7 if value.is_a?(Time) || value.is_a?(Date)

    value
  end
end
