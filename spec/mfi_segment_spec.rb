# encoding: UTF-8
require 'spec_helper'

describe HL7::Message::Segment::MFI do
  context 'general' do
    before :all do
      @base_sft = 'MFI|HL70006^RELIGION^HL70175|TEST|UPD|||AL'
    end

    it 'creates an MFI segment' do
      lambda do
        sft = described_class.new( @base_sft )
        sft.should_not be_nil
        sft.to_s.should == @base_sft
      end.should_not raise_error
    end

    it 'allows access to an MFI segment' do
      lambda do
        sft = described_class.new( @base_sft )
        sft.master_file_identifier.should eq 'HL70006^RELIGION^HL70175'
        sft.master_file_application_identifier.should eq 'TEST'
        sft.file_level_event_code.should eq 'UPD'
        sft.response_level_code.should eq 'AL'
      end.should_not raise_error
    end
  end
end
