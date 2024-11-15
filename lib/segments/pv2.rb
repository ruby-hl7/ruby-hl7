# frozen_string_literal: true

class HL7::Message::Segment::PV2 < HL7::Message::Segment
  weight 3
  add_field :prior_pending_location, :idx => 1
  add_field :accommodation_code, :idx => 2
  add_field :admit_reason, :idx => 3
  add_field :transfer_reason, :idx => 4
  add_field :patient_valuables, :idx => 5
  add_field :patient_valuables_location, :idx => 6
  add_field :visit_user_code, :idx => 7
  add_field :expected_admit_date, :idx => 8
  add_field :expected_discharge_date, :idx => 9
  add_field :estimated_inpatient_stay_length, :idx => 10
  add_field :actual_inpatient_stay_length, :idx => 11
  add_field :visit_description, :idx => 12
  add_field :referral_source_code, :idx => 13
  add_field :previous_service_date, :idx => 14
  add_field :employment_illness_related_indicator, :idx => 15
  add_field :purge_status_code, :idx => 16
  add_field :purge_status_date, :idx => 17
  add_field :special_program_code, :idx => 18
  add_field :retention_indicator, :idx => 19
  add_field :expected_number_of_insurance_plans, :idx => 20
  add_field :visit_publicity_code, :idx => 21
  add_field :visit_protection_indicator, :idx => 22
  add_field :clinic_organization_name, :idx => 23
  add_field :patient_status_code, :idx => 24
  add_field :visit_priority_code, :idx => 25
  add_field :previous_treatment_date, :idx => 26
  add_field :expected_discharge_disposition, :idx => 27
  add_field :signature_on_file, :idx => 28
  add_field :first_similar_illness_date, :idx => 29
  add_field :patient_charge_adjustment_code, :idx => 30
  add_field :recurring_service_code, :idx => 31
  add_field :billing_media_code, :idx => 32
  add_field :expected_surgery_date, :idx => 33
  add_field :military_partnership_code, :idx => 34
  add_field :military_non_availibility_code, :idx => 35
  add_field :newborn_baby_indicator, :idx => 36
  add_field :baby_detained_indicator, :idx => 37
  add_field :mode_of_arrival_code, :idx => 38
  add_field :recreational_drug_use_code, :idx => 39
  add_field :admission_level_of_care_code, :idx => 40
  add_field :precaution_code, :idx => 41
  add_field :patient_condition_code, :idx => 42
  add_field :living_will_code, :idx => 43
  add_field :organ_donor_code, :idx => 44
  add_field :advance_directive_code, :idx => 45
  add_field :patient_status_effective_date, :idx => 46
  add_field :expected_loa_return_date, :idx => 47
  add_field :expected_preadmission_testing_date, :idx => 48
  add_field :notify_clergy_code, :idx => 49
end
