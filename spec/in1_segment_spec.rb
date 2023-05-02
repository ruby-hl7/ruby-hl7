require 'spec_helper'

describe HL7::Message::Segment::IN1 do
  context 'general' do
    before :all do
      @base_in1 = 'IN1|1||752|ACORDIA NATIONAL||||A|GRP|||||||SMITH^JOHN|19|19700102||||||||||||||||||WC23732763278A|||||||||||||||||X'
    end

    it 'creates an IN1 segment' do
      expect do
        in1 = described_class.new(@base_in1)
        expect(in1).not_to be_nil
        expect(in1.to_s).to eq @base_in1
      end.not_to raise_error
    end

    it 'allows access to an IN1 segment' do
      expect do
        in1 = described_class.new(@base_in1)
        expect(in1.set_id).to eq '1'
        expect(in1.insurance_company_id).to eq '752'
        expect(in1.insurance_company_name).to eq 'ACORDIA NATIONAL'
        expect(in1.group_number).to eq 'A'
        expect(in1.group_name).to eq 'GRP'
        expect(in1.name_of_insured).to eq 'SMITH^JOHN'
        expect(in1.insureds_relationship_to_patient).to eq '19'
        expect(in1.insureds_date_of_birth).to eq '19700102'
        expect(in1.policy_number).to eq 'WC23732763278A'
        expect(in1.vip_indicator).to eq 'X'
      end.not_to raise_error
    end
  end
end
