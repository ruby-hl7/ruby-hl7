# frozen_string_literal: true

require "spec_helper"

describe HL7::Message::Segment::PR1 do
  let(:segment_string) do
    "PR1|1|CPT|99244|Consultation-Level 4|20150325000000|functional_type|minutes|anesthesiologist|" \
      "anesthesia_code|anesthesia_minutes|123^Physician^Dr|B69^Cysticercosis^I10~B60.0^Babesiosis^I10|" \
      "consent_code|priority|associated_diagnosis_code|code_modifier|drg_type|tissue_type_code|identifier|" \
      "action_code|drg_procedure_determination_status|drg_procedure_relevance|treating_organizational_unit|" \
      "respiratory_within_surgery|parent_procedure_id"
  end
  let(:filled_pr1) { HL7::Message::Segment::PR1.new(segment_string) }

  it "allows access to a PR1 segment's attributes" do
    expect(filled_pr1.set_id).to eq("1")
    expect(filled_pr1.coding_method).to eq("CPT")
    expect(filled_pr1.code).to eq("99244")
    expect(filled_pr1.description).to eq("Consultation-Level 4")
    expect(filled_pr1.date_time).to eq("20150325000000")
    expect(filled_pr1.functional_type).to eq("functional_type")
    expect(filled_pr1.minutes).to eq("minutes")
    expect(filled_pr1.anesthesiologist).to eq("anesthesiologist")
    expect(filled_pr1.anesthesia_code).to eq("anesthesia_code")
    expect(filled_pr1.anesthesia_minutes).to eq("anesthesia_minutes")
    expect(filled_pr1.surgeon).to eq("123^Physician^Dr")
    expect(filled_pr1.practitioner).to eq("B69^Cysticercosis^I10~B60.0^Babesiosis^I10")
    expect(filled_pr1.consent_code).to eq("consent_code")
    expect(filled_pr1.priority).to eq("priority")
    expect(filled_pr1.associated_diagnosis_code).to eq("associated_diagnosis_code")
    expect(filled_pr1.code_modifier).to eq("code_modifier")
    expect(filled_pr1.drg_type).to eq("drg_type")
    expect(filled_pr1.tissue_type_code).to eq("tissue_type_code")
    expect(filled_pr1.identifier).to eq("identifier")
    expect(filled_pr1.action_code).to eq("action_code")
    expect(filled_pr1.drg_procedure_determination_status).to eq("drg_procedure_determination_status")
    expect(filled_pr1.drg_procedure_relevance).to eq("drg_procedure_relevance")
    expect(filled_pr1.treating_organizational_unit).to eq("treating_organizational_unit")
    expect(filled_pr1.respiratory_within_surgery).to eq("respiratory_within_surgery")
    expect(filled_pr1.parent_procedure_id).to eq("parent_procedure_id")
  end

  describe "segment creation" do
    let(:pr1) { HL7::Message::Segment::PR1.new }
    let(:expected_segment_string) do
      "PR1|1|CPT|99244|Consultation-Level 4|20150325000000|functional_type|minutes|anesthesiologist|" \
        "anesthesia_code|anesthesia_minutes|123^Physician^Dr|B69^Cysticercosis^I10~B60.0^Babesiosis^I10|" \
        "consent_code|priority|associated_diagnosis_code|code_modifier|drg_type|tissue_type_code|identifier|" \
        "action_code|drg_procedure_determination_status|drg_procedure_relevance|treating_organizational_unit|" \
        "respiratory_within_surgery|parent_procedure_id"
    end

    before do
      pr1.set_id = "1"
      pr1.coding_method = "CPT"
      pr1.code = "99244"
      pr1.description = "Consultation-Level 4"
      pr1.date_time = "20150325000000"
      pr1.functional_type = "functional_type"
      pr1.minutes = "minutes"
      pr1.anesthesiologist = "anesthesiologist"
      pr1.anesthesia_code = "anesthesia_code"
      pr1.anesthesia_minutes = "anesthesia_minutes"
      pr1.surgeon = "123^Physician^Dr"
      pr1.practitioner = "B69^Cysticercosis^I10~B60.0^Babesiosis^I10"
      pr1.consent_code = "consent_code"
      pr1.priority = "priority"
      pr1.associated_diagnosis_code = "associated_diagnosis_code"
      pr1.code_modifier = "code_modifier"
      pr1.drg_type = "drg_type"
      pr1.tissue_type_code = "tissue_type_code"
      pr1.identifier = "identifier"
      pr1.action_code = "action_code"
      pr1.drg_procedure_determination_status = "drg_procedure_determination_status"
      pr1.drg_procedure_relevance = "drg_procedure_relevance"
      pr1.treating_organizational_unit = "treating_organizational_unit"
      pr1.respiratory_within_surgery = "respiratory_within_surgery"
      pr1.parent_procedure_id = "parent_procedure_id"
    end

    it "serializes a PRT segment" do
      expect(pr1.to_s).to eq(expected_segment_string)
    end
  end
end
