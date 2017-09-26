# encoding: UTF-8
require 'spec_helper'

describe HL7::Message::Segment::PV1 do
  context 'general' do
    before :all do
      @base = "PV1||R|||||||||||||||A|||V02^19900607~H02^19900607"
    end

    it 'allows access to an PV1 segment' do
      pv1 = HL7::Message::Segment::PV1.new @base
      pv1.patient_class.should eq "R"
    end

    it 'allows creation of an OBX segment' do
      pv1= HL7::Message::Segment::PV1.new
      pv1.referring_doctor="Smith^John"
      pv1.referring_doctor.should eq "Smith^John"
      pv1.admit_date = Date.new(2014, 1, 1)
      pv1.admit_date.should eq '20140101'
    end
  end
end
