# encoding: UTF-8
require 'spec_helper'

describe HL7::Message::Segment::PRD do
  context 'general' do
    let (:base) { 'PRD|RP|LastName^FirstName^MiddleInitial^SR^NickName|444 Home Street^Apt B^Ann Arbor^MI^99999^USA|^^^A Wonderful Clinic|^WPN^PH^^^07^5555555|PH|4796^AUSHICPR|20130109163307+1000|20140109163307+1000' }
    let (:prd) { HL7::Message::Segment::PRD.new base }

    it 'should set the provider_role' do
      expect(prd.provider_role).to eql 'RP'
    end

    it 'should set the name' do
      expect(prd.provider_name).to eql 'LastName^FirstName^MiddleInitial^SR^NickName'
    end

    it 'should set the provider_address' do
      expect(prd.provider_address).to eql '444 Home Street^Apt B^Ann Arbor^MI^99999^USA'
    end

    it 'should set the provider_location' do
      expect(prd.provider_location).to eql '^^^A Wonderful Clinic'
    end

    it 'should set provider_communication_information' do
      expect(prd.provider_communication_information).to eql '^WPN^PH^^^07^5555555'
    end
  end
end
