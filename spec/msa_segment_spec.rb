$LOAD_PATH << '../lib'
require 'ruby-hl7'

describe HL7::Message::Segment::MSA do
  context 'general' do
    before :all do
      @base_msa = 'MSA|AR|ZZ9380 ERR'
    end

    it 'creates an MSA segment' do
      expect do
        msa = described_class.new(@base_msa)
        expect(msa).not_to be_nil
        expect(msa.to_s).to eq @base_msa
      end.not_to raise_error
    end

    it 'allows access to an MSA segment' do
      expect do
        msa = described_class.new(@base_msa)
        expect(msa.ack_code).to eq 'AR'
        expect(msa.control_id).to eq 'ZZ9380 ERR'
      end.not_to raise_error
    end
  end
end
