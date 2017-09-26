# encoding: UTF-8
require 'spec_helper'

describe HL7::Message::Segment::ERR do
  context 'general' do
    before :all do
      @base_err = 'ERR||OBR^1|100^Segment sequence error^HL70357|E|||Missing required OBR segment|Email help desk for further information on this error||||^NET^Internet^helpdesk@hl7.org'
    end

    it 'creates an ERR segment' do
      lambda do
        err = HL7::Message::Segment::ERR.new( @base_err )
        err.should_not be_nil
        err.to_s.should eq @base_err
      end.should_not raise_error
    end

    it 'allows access to an ERR segment' do
      lambda do
        err = HL7::Message::Segment::ERR.new( @base_err )
        err.severity.should eq 'E'
        err.error_location.should eq 'OBR^1'
      end.should_not raise_error
    end
  end
end
