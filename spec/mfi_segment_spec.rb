# frozen_string_literal: true

require "spec_helper"

describe HL7::Message::Segment::MFI do
  context "general" do
    before :all do
      @base_sft = "MFI|HL70006^RELIGION^HL70175|TEST|UPD|||AL"
    end

    it "creates an MFI segment" do
      expect do
        sft = described_class.new(@base_sft)
        expect(sft).not_to be_nil
        expect(sft.to_s).to eq(@base_sft)
      end.not_to raise_error
    end

    it "allows access to an MFI segment" do
      expect do
        sft = described_class.new(@base_sft)
        expect(sft.master_file_identifier).to eq "HL70006^RELIGION^HL70175"
        expect(sft.master_file_application_identifier).to eq "TEST"
        expect(sft.file_level_event_code).to eq "UPD"
        expect(sft.response_level_code).to eq "AL"
      end.not_to raise_error
    end
  end
end
