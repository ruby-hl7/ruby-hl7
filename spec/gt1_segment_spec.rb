require 'spec_helper'

describe HL7::Message::Segment::GT1 do
  context 'general' do
    before :all do
      @base_gt1 = 'GT1||440|Crusher^Beverly||1003 Elm Street^^Enterprise^MD^29433|(330)644-1234^^^bcrusher@ufp.net^^330^6441234| |19600411000000|F||18|339-33-6657||||||||F||||||||||M'
    end

    it 'creates an GT1 segment' do
      expect do
        gt1 = described_class.new(@base_gt1)
        expect(gt1).not_to be_nil
        expect(gt1.to_s).to eq @base_gt1
      end.not_to raise_error
    end

    it 'allows access to an GT1 segment' do
      expect do
        gt1 = described_class.new(@base_gt1)
        expect(gt1.guarantor_number).to eq '440'
        expect(gt1.guarantor_name).to eq 'Crusher^Beverly'
        expect(gt1.guarantor_address).to eq '1003 Elm Street^^Enterprise^MD^29433'
        expect(gt1.guarantor_date_of_birth).to eq '19600411000000'
        expect(gt1.guarantor_sex).to eq 'F'
        expect(gt1.guarantor_relationship).to eq '18'
        expect(gt1.guarantor_ssn).to eq '339-33-6657'
        expect(gt1.guarantor_employment_status).to eq 'F'
      end.not_to raise_error
    end
  end
end
