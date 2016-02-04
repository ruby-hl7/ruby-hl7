require 'ruby-hl7'
class HL7::Message::Segment::GT1 < HL7::Message::Segment
  add_field :set_id
  add_field :guarantor_number
  add_field :guarantor_name
  add_field :guarantor_spouse_name
  add_field :guarantor_address
  add_field :guarantor_phone_home
  add_field :guarantor_phone_business
  add_field :guarantor_date_of_birth do |value|
    convert_to_ts(value)
  end
  add_field :guarantor_sex
  add_field :guarantor_type
  add_field :guarantor_relationship
  add_field :guarantor_social_security_num
  add_field :guarantor_begin_date
  add_field :guarantor_end_date
  add_field :guarantor_priority
  add_field :guarantor_employer_name
  add_field :guarantor_employer_address
  add_field :guarantor_employer_phone
  add_field :guarantor_employee_id
  add_field :guarantor_employment_status
  add_field :guarantor_organization_name
  add_field :guarantor_billing_hold_flag
  add_field :guarantor_credit_rating_code
  add_field :guarantor_death_date do |value|
    convert_to_ts(value)
  end
  add_field :guarantor_death_flag
  add_field :guarantor_charge_adj_code
  add_field :guarantor_household_annual_income
  add_field :guarantor_household_size
  add_field :guarantor_employer_id_num
  add_field :guarantor_marital_status
  add_field :guarantor_hire_effective_date
  add_field :employment_stop_date
  add_field :living_dependency
  add_field :ambulatory_status
  add_field :citizenship
  add_field :primary_language
  add_field :living_arrangement
  add_field :publicity_indicator
  add_field :protection_indicator
  add_field :student_indicator
  add_field :religion
  add_field :mothers_maiden_name
  add_field :nationality
  add_field :ethnic_group
  add_field :contact_persons_name
  add_field :contact_persons_phone
  add_field :contact_reason
  add_field :contact_relationship
  add_field :job_title
  add_field :job_code_class
  add_field :guarantor_employers_org_name
  add_field :handicap
  add_field :job_status
  add_field :guarantor_financial_class
  add_field :guarantor_race
end
