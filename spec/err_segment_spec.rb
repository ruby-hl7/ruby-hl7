require 'spec_helper'

describe HL7::Message::Segment::ERR do
  context 'general' do
    before :all do
      @base_err = 'ERR||OBR^1|100^Segment sequence error^HL70357|E|||Missing required OBR segment|Email help desk for further information on this error||||^NET^Internet^helpdesk@hl7.org'
    end

    it 'creates an ERR segment' do
      expect do
        err = described_class.new(@base_err)
        expect(err).not_to be_nil
        expect(err.to_s).to eq @base_err
      end.not_to raise_error
    end

    it 'allows access to an ERR segment' do
      expect do
        err = described_class.new(@base_err)
        expect(err.severity).to eq 'E'
        expect(err.error_location).to eq 'OBR^1'
      end.not_to raise_error
    end
  end
end
