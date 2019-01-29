# encoding: UTF-8
require 'spec_helper'

describe HL7::Message::Segment::PV1 do
  context 'general' do
    before :all do
      @base = "PV1||R|||||||||||||||A|||V02^19900607~H02^19900607"
    end

    it 'allows access to an PV1 segment' do
      pv1 = HL7::Message::Segment::PV1.new @base
      expect(pv1.patient_class).to eq "R"
    end

    it 'allows creation of an OBX segment' do
      pv1= HL7::Message::Segment::PV1.new
      pv1.referring_doctor="Smith^John"
      expect(pv1.referring_doctor).to eq "Smith^John"
      pv1.admit_date = Date.new(2014, 1, 1)
      expect(pv1.admit_date).to eq '20140101'
    end
  end
end
