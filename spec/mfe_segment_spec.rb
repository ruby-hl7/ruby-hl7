# frozen_string_literal: true

require "spec_helper"

describe HL7::Message::Segment::MFE do
  context "general" do
    before :all do
      @base_sft = "MFE|MAD|6772331|200106290500|BUD^Buddhist^HL70006|CE"
    end

    it "creates an MFE segment" do
      expect do
        sft = HL7::Message::Segment::MFE.new(@base_sft)
        expect(sft).not_to be_nil
        expect(sft.to_s).to eq(@base_sft)
      end.not_to raise_error
    end

    it "allows access to an MFE segment" do
      expect do
        sft = HL7::Message::Segment::MFE.new(@base_sft)
        expect(sft.record_level_event_code).to eq "MAD"
        expect(sft.mfn_control_id).to eq "6772331"
        expect(sft.primary_key_value).to eq "BUD^Buddhist^HL70006"
        expect(sft.primary_key_value_type).to eq "CE"
      end.not_to raise_error
    end
  end
end
