# frozen_string_literal: true

class HL7::Message::Segment::ROL < HL7::Message::Segment
  add_field :role_instance, :idx => 1
  add_field :action_code, :idx => 2
  add_field :role, :idx => 3
  add_field :role_person, :idx => 4
  add_field :role_begin_date_time, :idx => 5 do |value|
    convert_to_ts(value)
  end
  add_field :role_end_date_time, :idx => 6 do |value|
    convert_to_ts(value)
  end
  add_field :role_duration, :idx => 7
  add_field :role_action_reason, :idx => 8
  add_field :provider_type, :idx => 9
  add_field :organization_unit_type, :idx => 10
  add_field :office_home_address_birthplace, :idx => 11
  add_field :phone_number, :idx => 12
  add_field :person_location, :idx => 13
  add_field :organization, :idx => 14
end
