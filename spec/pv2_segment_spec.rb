# frozen_string_literal: true

require "spec_helper"

# rubocop:disable RSpec/MultipleExpectations, RSpec/ExampleLength
# reason: we need to assert every segment field to be exhaustive
describe HL7::Message::Segment::PV2 do
  let(:filled_pv2) { HL7::Message::Segment::PV2.new(segment_string) }

  let(:segment_string) do
    "PV2|prior_pending_location|accommodation_code|admit_reason|transfer_reason|patient_valuables" \
      "|patient_valuables_location|visit_user_code|expected_admit_date|expected_discharge_date" \
      "|estimated_length_of_inpatient_stay|actual_length_of_inpatient_stay|visit_description|referral_source_code" \
      "|previous_service_date|employment_illness_related_indicator|purge_status_code|purge_status_date" \
      "|special_program_code|retention_indicator|expected_number_of_insurance_plans|visit_publicity_code" \
      "|visit_protection_indicator|clinic_organization_name|patient_status_code|visit_priority_code" \
      "|previous_treatment_date|expected_discharge_disposition|signature_on_file" \
      "|first_similar_illness_date|patient_charge_adjustment_code|recurring_service_code|billing_media_code" \
      "|expected_surgery_date|military_partnership_code|military_non_availability_code|newborn_baby_indicator" \
      "|baby_detained_indicator|mode_of_arrival_code|recreational_drug_use_code|admission_level_of_care_code" \
      "|precaution_code|patient_condition_code|living_will_code|organ_donor_code|advance_directive_code" \
      "|patient_status_effective_date|expected_loa_return_date|expected_preadmission_testing_date" \
      "|notify_clergy_code"
  end

  describe "segment parsing" do
    it "allows access to a PV2 segment's attributes" do
      expect(filled_pv2.prior_pending_location).to eq("prior_pending_location")
      expect(filled_pv2.accommodation_code).to eq("accommodation_code")
      expect(filled_pv2.admit_reason).to eq("admit_reason")
      expect(filled_pv2.transfer_reason).to eq("transfer_reason")
      expect(filled_pv2.patient_valuables).to eq("patient_valuables")
      expect(filled_pv2.patient_valuables_location).to eq("patient_valuables_location")
      expect(filled_pv2.visit_user_code).to eq("visit_user_code")
      expect(filled_pv2.expected_admit_date).to eq("expected_admit_date")
      expect(filled_pv2.expected_discharge_date).to eq("expected_discharge_date")
      expect(filled_pv2.estimated_inpatient_stay_length).to eq("estimated_length_of_inpatient_stay")
      expect(filled_pv2.actual_inpatient_stay_length).to eq("actual_length_of_inpatient_stay")
      expect(filled_pv2.visit_description).to eq("visit_description")
      expect(filled_pv2.referral_source_code).to eq("referral_source_code")
      expect(filled_pv2.previous_service_date).to eq("previous_service_date")
      expect(filled_pv2.employment_illness_related_indicator).to eq("employment_illness_related_indicator")
      expect(filled_pv2.purge_status_code).to eq("purge_status_code")
      expect(filled_pv2.purge_status_date).to eq("purge_status_date")
      expect(filled_pv2.special_program_code).to eq("special_program_code")
      expect(filled_pv2.retention_indicator).to eq("retention_indicator")
      expect(filled_pv2.expected_number_of_insurance_plans).to eq("expected_number_of_insurance_plans")
      expect(filled_pv2.visit_publicity_code).to eq("visit_publicity_code")
      expect(filled_pv2.visit_protection_indicator).to eq("visit_protection_indicator")
      expect(filled_pv2.clinic_organization_name).to eq("clinic_organization_name")
      expect(filled_pv2.patient_status_code).to eq("patient_status_code")
      expect(filled_pv2.visit_priority_code).to eq("visit_priority_code")
      expect(filled_pv2.previous_treatment_date).to eq("previous_treatment_date")
      expect(filled_pv2.expected_discharge_disposition).to eq("expected_discharge_disposition")
      expect(filled_pv2.signature_on_file).to eq("signature_on_file")
      expect(filled_pv2.first_similar_illness_date).to eq("first_similar_illness_date")
      expect(filled_pv2.patient_charge_adjustment_code).to eq("patient_charge_adjustment_code")
      expect(filled_pv2.recurring_service_code).to eq("recurring_service_code")
      expect(filled_pv2.billing_media_code).to eq("billing_media_code")
      expect(filled_pv2.expected_surgery_date).to eq("expected_surgery_date")
      expect(filled_pv2.military_partnership_code).to eq("military_partnership_code")
      expect(filled_pv2.military_non_availability_code).to eq("military_non_availability_code")
      expect(filled_pv2.newborn_baby_indicator).to eq("newborn_baby_indicator")
      expect(filled_pv2.baby_detained_indicator).to eq("baby_detained_indicator")
      expect(filled_pv2.mode_of_arrival_code).to eq("mode_of_arrival_code")
      expect(filled_pv2.recreational_drug_use_code).to eq("recreational_drug_use_code")
      expect(filled_pv2.admission_level_of_care_code).to eq("admission_level_of_care_code")
      expect(filled_pv2.precaution_code).to eq("precaution_code")
      expect(filled_pv2.patient_condition_code).to eq("patient_condition_code")
      expect(filled_pv2.living_will_code).to eq("living_will_code")
      expect(filled_pv2.organ_donor_code).to eq("organ_donor_code")
      expect(filled_pv2.advance_directive_code).to eq("advance_directive_code")
      expect(filled_pv2.patient_status_effective_date).to eq("patient_status_effective_date")
      expect(filled_pv2.expected_loa_return_date).to eq("expected_loa_return_date")
      expect(filled_pv2.expected_preadmission_testing_date).to eq("expected_preadmission_testing_date")
      expect(filled_pv2.notify_clergy_code).to eq("notify_clergy_code")
    end
  end

  describe "segment creation" do
    let(:pv2) { HL7::Message::Segment::PV2.new }
    let(:expected_segment_string) do
      "PV2|prior_pending_location|accommodation_code|admit_reason|transfer_reason|patient_valuables" \
        "|patient_valuables_location|visit_user_code|expected_admit_date|expected_discharge_date" \
        "|estimated_length_of_inpatient_stay|actual_length_of_inpatient_stay|visit_description|referral_source_code" \
        "|previous_service_date|employment_illness_related_indicator|purge_status_code|purge_status_date" \
        "|special_program_code|retention_indicator|expected_number_of_insurance_plans|visit_publicity_code" \
        "|visit_protection_indicator|clinic_organization_name|patient_status_code|visit_priority_code" \
        "|previous_treatment_date|expected_discharge_disposition|signature_on_file" \
        "|first_similar_illness_date|patient_charge_adjustment_code|recurring_service_code|billing_media_code" \
        "|expected_surgery_date|military_partnership_code|military_non_availability_code|newborn_baby_indicator" \
        "|baby_detained_indicator|mode_of_arrival_code|recreational_drug_use_code|admission_level_of_care_code" \
        "|precaution_code|patient_condition_code|living_will_code|organ_donor_code|advance_directive_code" \
        "|patient_status_effective_date|expected_loa_return_date|expected_preadmission_testing_date" \
        "|notify_clergy_code"
    end

    before do
      pv2.prior_pending_location = "prior_pending_location"
      pv2.accommodation_code = "accommodation_code"
      pv2.admit_reason = "admit_reason"
      pv2.transfer_reason = "transfer_reason"
      pv2.patient_valuables = "patient_valuables"
      pv2.patient_valuables_location = "patient_valuables_location"
      pv2.visit_user_code = "visit_user_code"
      pv2.expected_admit_date = "expected_admit_date"
      pv2.expected_discharge_date = "expected_discharge_date"
      pv2.estimated_inpatient_stay_length = "estimated_length_of_inpatient_stay"
      pv2.actual_inpatient_stay_length = "actual_length_of_inpatient_stay"
      pv2.visit_description = "visit_description"
      pv2.referral_source_code = "referral_source_code"
      pv2.previous_service_date = "previous_service_date"
      pv2.employment_illness_related_indicator = "employment_illness_related_indicator"
      pv2.purge_status_code = "purge_status_code"
      pv2.purge_status_date = "purge_status_date"
      pv2.special_program_code = "special_program_code"
      pv2.retention_indicator = "retention_indicator"
      pv2.expected_number_of_insurance_plans = "expected_number_of_insurance_plans"
      pv2.visit_publicity_code = "visit_publicity_code"
      pv2.visit_protection_indicator = "visit_protection_indicator"
      pv2.clinic_organization_name = "clinic_organization_name"
      pv2.patient_status_code = "patient_status_code"
      pv2.visit_priority_code = "visit_priority_code"
      pv2.previous_treatment_date = "previous_treatment_date"
      pv2.expected_discharge_disposition = "expected_discharge_disposition"
      pv2.signature_on_file = "signature_on_file"
      pv2.first_similar_illness_date = "first_similar_illness_date"
      pv2.patient_charge_adjustment_code = "patient_charge_adjustment_code"
      pv2.recurring_service_code = "recurring_service_code"
      pv2.billing_media_code = "billing_media_code"
      pv2.expected_surgery_date = "expected_surgery_date"
      pv2.military_partnership_code = "military_partnership_code"
      pv2.military_non_availability_code = "military_non_availability_code"
      pv2.newborn_baby_indicator = "newborn_baby_indicator"
      pv2.baby_detained_indicator = "baby_detained_indicator"
      pv2.mode_of_arrival_code = "mode_of_arrival_code"
      pv2.recreational_drug_use_code = "recreational_drug_use_code"
      pv2.admission_level_of_care_code = "admission_level_of_care_code"
      pv2.precaution_code = "precaution_code"
      pv2.patient_condition_code = "patient_condition_code"
      pv2.living_will_code = "living_will_code"
      pv2.organ_donor_code = "organ_donor_code"
      pv2.advance_directive_code = "advance_directive_code"
      pv2.patient_status_effective_date = "patient_status_effective_date"
      pv2.expected_loa_return_date = "expected_loa_return_date"
      pv2.expected_preadmission_testing_date = "expected_preadmission_testing_date"
      pv2.notify_clergy_code = "notify_clergy_code"
    end

    it "serializes a PV2 segment" do
      expect(pv2.to_s).to eq(expected_segment_string)
    end
  end

  describe "military_non_availibility_code" do
    it "aliases the military_non_availability_code field as military_non_availibility_code for backward compatibility" do
      expect(filled_pv2.military_non_availibility_code).to eq "military_non_availability_code"
      filled_pv2.military_non_availibility_code = "test"
      expect(filled_pv2.military_non_availibility_code).to eq "test"
    end
  end
end
# rubocop:enable RSpec/MultipleExpectations, RSpec/ExampleLength
