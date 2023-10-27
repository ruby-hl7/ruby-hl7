# encoding: UTF-8
# https://hl7-definition.caristix.com/v2/HL7v2.3.1/Segments/NK1
class HL7::Message::Segment::NK1 < HL7::Message::Segment
  add_field :set_id
  add_field :name
  add_field :relationship
  add_field :address
  add_field :phone_number
  add_field :business_phone_number
  add_field :contact_role
  add_field :start_date do |value|
    convert_to_ts(value)
  end
  add_field :end_date do |value|
    convert_to_ts(value)
  end
  add_field :job_title
  add_field :job_code
  add_field :employee_number
  add_field :organization_name, :idx => 13
  add_field :marital_status
  add_field :sex # TODO: raise HL7::InvalidDataError.new( "bad administrative sex value (not F|M|O|U|A|N|C)" ) ?
  add_field :dob do |value|
    convert_to_ts(value)
  end
  add_field :living_dependency
  add_field :ambulatory_status
  add_field :citizenship
  add_field :primary_language, :idx => 20
  add_field :living_arrangement
  add_field :publicity_code
  add_field :protection_indicator
  add_field :student_indicator
  add_field :religion
  add_field :mother_maiden_name
  add_field :nationality
  add_field :ethnic_group
  add_field :contact_reason
  add_field :contact_persons_name, :idx => 30
  add_field :contact_persons_telephone_number
  add_field :contact_persons_address
  add_field :identifiers
  add_field :job_status
  add_field :race
  add_field :handicap
  add_field :contact_persons_ssn
end
