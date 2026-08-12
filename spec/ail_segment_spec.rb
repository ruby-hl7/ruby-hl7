# frozen_string_literal: true

require "spec_helper"

describe HL7::Message::Segment::AIL do
  context "general" do
    before :all do
      @base_ail = "AIL|1|A|OFFICE^^^OFFICE|^OFFICE^A4"
    end

    it "creates an AIL segment" do
      expect do
        ail = HL7::Message::Segment::AIL.new(@base_ail)
        expect(ail).not_to be_nil
        expect(ail.to_s).to eq @base_ail
      end.not_to raise_error
    end

    it "allows access to an AIL segment" do
      expect do
        ail = HL7::Message::Segment::AIL.new(@base_ail)
        expect(ail.set_id).to eq "1"
        expect(ail.segment_action_code).to eq "A"
        expect(ail.location_resource_id).to eq "OFFICE^^^OFFICE"
        expect(ail.location_type).to eq "^OFFICE^A4"
      end.not_to raise_error
    end
  end
end
