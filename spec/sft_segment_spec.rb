# encoding: UTF-8
require 'spec_helper'

describe HL7::Message::Segment::SFT do
  context 'general' do
    before :all do
      @base_sft = 'SFT|Level Seven Healthcare Software, Inc.^L^^^^&2.16.840.1.113883.19.4.6^ISO^XX^^^1234|1.2|An Lab System|56734||20080817'
    end

    it 'creates an SFT segment' do
      expect do
        sft = HL7::Message::Segment::SFT.new( @base_sft )
        expect(sft).not_to be_nil
        expect(sft.to_s).to eq @base_sft
      end.not_to raise_error
    end

    it 'allows access to an SFT segment' do
      expect do
        sft = HL7::Message::Segment::SFT.new( @base_sft )
        expect(sft.software_product_name).to eq 'An Lab System'
        expect(sft.software_install_date).to eq '20080817'
      end.not_to raise_error
    end
  end
end
