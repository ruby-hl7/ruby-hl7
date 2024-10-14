module HL7
  class Message::Segment::GT1 < HL7::Message::Segment
    add_field :set_id
    add_field :guarantor_number
    add_field :guarantor_name
    add_field :guarantor_spouse_name
    add_field :guarantor_address
    add_field :guarantor_home_phone
    add_field :guarantor_business_phone
    add_field :guarantor_date_of_birth
    add_field :guarantor_sex do |sex|
      unless /^[FMOUANC]$/.match(sex) || sex.nil? || sex == ""
        raise HL7::InvalidDataError.new("bad administrative sex value (not F|M|O|U|A|N|C)")
      end

      sex ||= ""
      sex
    end
    add_field :guarantor_type
    add_field :guarantor_relationship
    add_field :guarantor_ssn
    add_field :guarantor_begin_date do |value|
      convert_to_ts(value)
    end
    add_field :guarantor_end_date do |value|
      convert_to_ts(value)
    end
    add_field :guarantor_priority
    add_field :guarantor_employer_name
    add_field :guarantor_employer_address
    add_field :guarantor_employer_phone
    add_field :guarantor_employee_id
    add_field :guarantor_employment_status
    add_field :guarantor_billing_hold_flag
    add_field :guarantor_date_of_death do |value|
      convert_to_ts(value)
    end
    add_field :guarantor_death_flag
    add_field :guarantor_charge_adjustment_code
    add_field :guarantor_household_annual_income
    add_field :guarantor_household_size
    add_field :guarantor_employer_id_number
    add_field :guarantor_marital_status_code
    add_field :guarantor_hire_effective_date do |value|
      convert_to_ts(value)
    end
    add_field :employment_stop_date do |value|
      convert_to_ts(value)
    end
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
    add_field :contact_persons_phone_number
    add_field :contact_reason
    add_field :contact_relationship
    add_field :contact_job_title
    add_field :job_code
    add_field :guarantor_employers_organization
    add_field :handicap
    add_field :job_status
    add_field :guarantor_financial_class
    add_field :guarantor_race
    add_field :guarantor_birth_place
    add_field :vip_indicator
  end
end
