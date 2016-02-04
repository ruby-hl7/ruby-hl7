require 'ruby-hl7'
class HL7::Message::Segment::IN2 < HL7::Message::Segment
  add_field :insureds_employee_id
  add_field :insureds_social_security_num
  add_field :insureds_employer_name
  add_field :employer_information_data
  add_field :mail_claim_party
  add_field :medicare_ins_card_number
  add_field :medicaid_case_name
  add_field :medicaid_case_num
  add_field :champus_sponsor_name
  add_field :champus_id_num
  add_field :dependent_of_champus_rcpnt
  add_field :champus_organization
  add_field :champus_station
  add_field :champus_service
  add_field :champus_rank_grade
  add_field :champus_status
  add_field :champus_retire_date do |value|
    convert_to_ts(value)
  end
  add_field :champus_non_avail_cert_on_file
  add_field :baby_coverage
  add_field :combine_baby_bill
  add_field :blood_deductible
  add_field :special_cvg_approval_name
  add_field :special_cvg_approval_title
  add_field :non_cvrd_ins_code
  add_field :payor_id
  add_field :payor_subscriber_id
  add_field :eligibility_source
  add_field :room_coverage_type_amt
  add_field :policy_type_amt
  add_field :daily_deductible
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
  add_field :marital_status
  add_field :insureds_employment_start_date do |value|
    convert_to_ts(value)
  end
  add_field :insureds_employment_stop_date do |value|
    convert_to_ts(value)
  end
  add_field :job_title
  add_field :job_code_class
  add_field :job_status
  add_field :employer_contact_person_name
  add_field :employer_contact_person_phone_num
  add_field :employer_contact_reason
  add_field :insureds_contact_person_name
  add_field :insureds_contact_person_phone_num
  add_field :insureds_contact_person_reason
  add_field :relationship_to_patient_start_dt do |value|
    convert_to_ts(value)
  end
  add_field :relationship_to_patient_stop_dt do |value|
    convert_to_ts(value)
  end
  add_field :insured_co_contact_reason
  add_field :insured_co_contact_phone
  add_field :policy_scope
  add_field :policy_source
  add_field :patient_member_number
  add_field :guarantor_relation_to_insured
  add_field :insureds_phone_home
  add_field :insureds_employer_phone
  add_field :military_handicapped_program
  add_field :suspend_flag
  add_field :copay_limit_flag
  add_field :stoploss_limit_flag
  add_field :insured_org_name_and_id
  add_field :insured_employer_org_name_id
  add_field :race
  add_field :hcfa_patient_relation_to_insured


end
