# frozen_string_literal: true

class HL7::Message::Segment::PV2 < HL7::Message::Segment
  weight 3
  add_field :prior_pending_location
  add_field :accommodation_code
  add_field :admit_reason
  add_field :transfer_reason
  add_field :patient_valuables
  add_field :patient_valuables_location
  add_field :visit_user_code
  add_field :expected_admit_date
  add_field :expected_discharge_date
  add_field :estimated_inpatient_stay_length
  add_field :actual_inpatient_stay_length
  add_field :visit_description
  add_field :referral_source_code
  add_field :previous_service_date
  add_field :employment_illness_related_indicator
  add_field :purge_status_code
  add_field :purge_status_date
  add_field :special_program_code
  add_field :retention_indicator
  add_field :expected_number_of_insurance_plans
  add_field :visit_publicity_code
  add_field :visit_protection_indicator
  add_field :clinic_organization_name
  add_field :patient_status_code
  add_field :visit_priority_code
  add_field :previous_treatment_date
  add_field :expected_discharge_disposition
  add_field :signature_on_file
  add_field :first_similar_illness_date
  add_field :patient_charge_adjustment_code
  add_field :recurring_service_code
  add_field :billing_media_code
  add_field :expected_surgery_date

  # Adding military fields
  %i[military_partnership_code
     military_non_availibility_code
     newborn_baby_indicator
     baby_detained_indicator
     mode_of_arrival_code
     recreational_drug_use_code
     precaution_code
     patient_condition_code
     living_will_code
     organ_donor_code
     advance_directive_code
     patient_status_effective_date
     expected_loa_return_date
     expected_preadmission_testing_date
     notify_clergy_code].each {|f| add_field f }
end
