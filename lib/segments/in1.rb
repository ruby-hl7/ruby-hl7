# frozen_string_literal: true

# via https://github.com/bbhoss/ruby-hl7/blob/master/lib/segments/in1.rb
class HL7::Message::Segment::IN1 < HL7::Message::Segment
  add_field :set_id
  add_field :insurance_plan_id
  add_field :insurance_company_id
  add_field :insurance_company_name
  add_field :insurance_company_address
  add_field :insurance_company_contact_person
  add_field :insurance_company_phone_number
  add_field :group_number
  add_field :group_name
  add_field :insureds_group_employee_id
  add_field :insureds_group_employee_name
  add_field :plan_effective_date
  add_field :plan_expiration_date
  add_field :authorization_information
  add_field :plan_type
  add_field :name_of_insured
  add_field :insureds_relationship_to_patient
  add_field :insureds_date_of_birth
  add_field :insureds_address
  add_field :assignment_of_benefits
  add_field :coordination_of_benefits
  add_field :coordination_of_benefits_priority
  add_field :notice_of_admission_flag
  add_field :notice_of_admission_date
  add_field :report_of_eligibility_flag
  add_field :report_of_eligibility_date
  add_field :release_information_code
  add_field :pre_admit_cert
  add_field :verification_date_time
  add_field :verification_by
  add_field :type_of_agreement_code
  add_field :billing_status
  add_field :lifetime_reserve_days
  add_field :delay_before_lr_day
  add_field :company_plan_code
  add_field :policy_number
  add_field :policy_deductible
  add_field :policy_limit_amount
  add_field :policy_limit_days
  add_field :room_rate_semi_private
  add_field :room_rate_private
  add_field :insureds_employment_status
  add_field :insureds_sex
  add_field :insureds_employer_address
  add_field :verification_status
  add_field :prior_insurance_plan_id
  add_field :coverage_type
  add_field :handicap
  add_field :insureds_id_number
  add_field :signature_code
  add_field :signature_code_date
  add_field :insureds_birth_place
  add_field :vip_indicator
end
