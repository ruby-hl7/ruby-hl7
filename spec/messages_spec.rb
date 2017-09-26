require 'spec_helper'

describe "HL7 Messages" do
  it 'processes multiple known messages without failing' do
    lambda do
      HL7MESSAGES.each_pair do |key, hl7|
        HL7::Message.new(hl7)
      end
    end.should_not raise_exception
  end

  describe 'MFN M13 Messages' do
    it "extracts the MSH" do
      expect(HL7::Message.new(HL7MESSAGES[:mfn_m13])[:MSH].sending_app).to eq 'HL7REG'
    end
    it 'extracts the MFI' do
      expect(HL7::Message.new(HL7MESSAGES[:mfn_m13])[:MFI].master_file_identifier).to eq 'HL70006^RELIGION^HL70175'
    end
    it 'extracts the MFE' do
      expect(HL7::Message.new(HL7MESSAGES[:mfn_m13])[:MFE][0].mfn_control_id).to eq '6772333'
      expect(HL7::Message.new(HL7MESSAGES[:mfn_m13])[:MFE][1].mfn_control_id).to eq '6772334'
    end
  end
end
