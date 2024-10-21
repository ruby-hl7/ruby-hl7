# frozen_string_literal: true

require "spec_helper"

describe HL7::Message::Segment::SCH do
  context "general" do
    before :all do
      @base_sch = "SCH|||||681|S^SCHEDULED|^BONE DENSITY PB,cf/RH |30^30 MINUTE APPOINTMENT|45|m|^^45^200905260930^200905261015|||||||||polly^^POLLY BRESCOCK|^^^^^^ ||||SCHEDULED"
    end

    it "creates an SCH segment" do
      expect do
        sch = HL7::Message::Segment::SCH.new(@base_sch)
        expect(sch).not_to be_nil
        expect(sch.to_s).to eq @base_sch
      end.not_to raise_error
    end

    it "allows access to an SCH segment" do
      expect do
        sch = HL7::Message::Segment::SCH.new(@base_sch)
        expect(sch.schedule_id).to eq "681"
        expect(sch.event_reason).to eq "S^SCHEDULED"
        expect(sch.appointment_reason).to eq "^BONE DENSITY PB,cf/RH "
        expect(sch.appointment_type).to eq "30^30 MINUTE APPOINTMENT"
        expect(sch.appointment_duration).to eq "45"
        expect(sch.appointment_duration_units).to eq "m"
        expect(sch.entered_by_person).to eq "polly^^POLLY BRESCOCK"
        expect(sch.filler_status_code).to eq "SCHEDULED"
      end.not_to raise_error
    end
  end
end
