# encoding: UTF-8
require 'spec_helper'

describe HL7::Message::Segment::EVN do
  context 'general' do
    before :all do
      @base = "EVN|A04|20060705000000"
    end

    it 'allows access to an EVN segment' do
      evn = HL7::Message::Segment::EVN.new @base
      evn.type_code.should eq "A04"
    end

    it 'allows creation of an EVN segment' do
      evn = HL7::Message::Segment::EVN.new
      evn.event_facility="A Facility"
      evn.event_facility.should eq 'A Facility'
      evn.recorded_date = Date.new 2001,2,3
      evn.recorded_date.should eq "20010203"
    end
  end
end
