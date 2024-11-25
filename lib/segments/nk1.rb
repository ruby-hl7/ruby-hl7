# frozen_string_literal: true

class HL7::Message::Segment::NK1 < HL7::Message::Segment
  add_field :set_id, :idx => 1
  add_field :name, :idx => 2
  add_field :relationship, :idx => 3
  add_field :address, :idx => 4
  add_field :phone_number, :idx => 5
  add_field :business_phone_number, :idx => 6
  add_field :contact_role, :idx => 7
  add_field :start_date, :idx => 8 do |value|
    convert_to_ts(value)
  end
  add_field :end_date, :idx => 9 do |value|
    convert_to_ts(value)
  end
  add_field :job_title, :idx => 10
  add_field :job_code, :idx => 11
  add_field :employee_number, :idx => 12
  add_field :organization_name, :idx => 13
  add_field :marital_status, :idx => 14
  add_field :admin_sex, :idx => 15 do |sex|
    unless /^[FMOUANC]$/.match(sex) || sex.nil? || sex == ""
      raise HL7::InvalidDataError, "bad administrative sex value (not F|M|O|U|A|N|C)"
    end

    sex ||= ""
    sex
  end
  add_field :date_of_birth, :idx => 16 do |value|
    convert_to_ts(value)
  end
  add_field :living_dependency, :idx => 17
  add_field :ambulatory_status, :idx => 18
  add_field :citizenship, :idx => 19
  add_field :primary_language, :idx => 20
  add_field :living_arrangement, :idx => 21
  add_field :publicity_code, :idx => 22
  add_field :protection_indicator, :idx => 23
  add_field :student_indicator, :idx => 24
  add_field :religion, :idx => 25
  add_field :mother_maiden_name, :idx => 26
  add_field :nationality, :idx => 27
  add_field :ethnic_group, :idx => 28
  add_field :contact_reason, :idx => 29
  add_field :contact_persons_name, :idx => 30
  add_field :contact_persons_telephone_number, :idx => 31
  add_field :contact_persons_address, :idx => 32
  add_field :identifiers, :idx => 33
  add_field :job_status, :idx => 34
  add_field :race, :idx => 35
  add_field :handicap, :idx => 36
  add_field :contact_persons_ssn, :idx => 37
  add_field :birth_place, :idx => 38
  add_field :vip_indicator, :idx => 39
  add_field :telecommunication_information, :idx => 40
  add_field :contact_persons_telecommunication_information, :idx => 41
end
