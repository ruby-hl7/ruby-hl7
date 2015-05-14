# encoding: UTF-8
require "spec_helper"

describe HL7::Message::Segment::DG1 do
  context "reading" do
    let(:base_string) do
      "DG1|1|I9|71596^OSTEOARTHROS NOS-L/LEG ^I9|OSTEOARTHROS NOS-L/LEG |20170615140551-0800||A|"
    end
    let(:segment){ HL7::Message::Segment::DG1.new(base_string) }

    it "allows access to an DG1 segment" do
      expect(segment.set_id).to eq("1")
      expect(segment.diagnosis_coding_method).to eq("I9")
      expect(segment.diagnosis_code).to eq("71596^OSTEOARTHROS NOS-L/LEG ^I9")
      expect(segment.diagnosis_description).to eq("OSTEOARTHROS NOS-L/LEG ")
      expect(segment.diagnosis_date_time).to eq("20170615140551-0800")
      expect(segment.diagnosis_type).to eq("")
      expect(segment.major_diagnostic_category).to eq("A")
      expect(segment.diagnosis_related_group).to eq("")
      expect(segment.drg_approval_indicator).to eq(nil)
      expect(segment.drg_grouper_review_code).to eq(nil)
      expect(segment.outlier_type).to eq(nil)
      expect(segment.outlier_days).to eq(nil)
      expect(segment.outlier_cost).to eq(nil)
      expect(segment.grouper_version_and_type).to eq(nil)
      expect(segment.diagnosis_priority).to eq(nil)
      expect(segment.diagnosis_clinician).to eq(nil)
      expect(segment.diagnosis_classification).to eq(nil)
      expect(segment.confidential_indicator).to eq(nil)
      expect(segment.attestation_date_time).to eq(nil)
    end
  end

  context "creating" do
    let(:segment){ HL7::Message::Segment::DG1.new }

    it "allows creation of an DGH segment" do
      segment.set_id = "2"
      expect(segment.set_id).to eq("2")
    end
  end
end
