# encoding: UTF-8
require 'spec_helper'

describe HL7::Message::Segment::PD1 do
  context 'general' do
    before :all do
      @base = "PD1|S|A|SACRED HEART HOSPITAL|12345^DOCTORSON^DOC^M|F||Y|Y|Y||F|Y|201011110924-0700||DNR|A|201011110924-0700|201011110924-0700|USA|E1|ACT"
    end

    it "sets values correctly" do
      pid = HL7::Message::Segment::PD1.new @base

      expect(pid.living_dependency).to eq "S"
      expect(pid.living_arrangement).to eq "A"
      expect(pid.patient_primary_facility).to eq "SACRED HEART HOSPITAL"
      expect(pid.patient_primary_care_provider_name_and_id_no).to eq "12345^DOCTORSON^DOC^M"
      expect(pid.student_indicator).to eq "F"
      expect(pid.handicap).to eq ""
      expect(pid.living_will_code).to eq "Y"
      expect(pid.organ_donor_code).to eq "Y"
      expect(pid.separate_bill).to eq "Y"
      expect(pid.duplicate_patient).to eq ""
      expect(pid.publicity_code).to eq "F"
      expect(pid.protection_indicator).to eq "Y"
      expect(pid.protection_indicator_effective_date).to eq "201011110924-0700"
      expect(pid.place_of_worship).to eq ""
      expect(pid.advance_directive_code).to eq "DNR"
      expect(pid.immunization_registry_status).to eq "A"
      expect(pid.immunization_registry_status_effective_date).to eq "201011110924-0700"
      expect(pid.publicity_code_effective_date).to eq "201011110924-0700"
      expect(pid.military_branch).to eq "USA"
      expect(pid.military_rank).to eq "E1"
      expect(pid.military_status).to eq "ACT"
    end
  end
end
