# encoding: UTF-8
require 'spec_helper'

describe HL7::Message::Segment::SFT do
  context 'general' do
    before :all do
      @base_sft = 'SFT|Level Seven Healthcare Software, Inc.^L^^^^&2.16.840.1.113883.19.4.6^ISO^XX^^^1234|1.2|An Lab System|56734||20080817'
    end

    it 'creates an SFT segment' do
      lambda do
        sft = HL7::Message::Segment::SFT.new( @base_sft )
        sft.should_not be_nil
        sft.to_s.should eq @base_sft
      end.should_not raise_error
    end

    it 'allows access to an SFT segment' do
      lambda do
        sft = HL7::Message::Segment::SFT.new( @base_sft )
        sft.software_product_name.should eq 'An Lab System'
        sft.software_install_date.should eq '20080817'
      end.should_not raise_error
    end
  end
end
