# encoding: UTF-8
require 'spec_helper'

describe HL7::Message::Segment::MSH do
  context 'general' do
    before :all do
      @base = "MSH|^~\\&||ABCHS||AUSDHSV|20070101112951||ADT^A04^ADT_A01|12334456778890|P|2.5|||NE|NE|AU|ASCII|ENGLISH|||AN ORG|||RECNET.ORG"
    end

    it 'allows access to an MSH segment' do
      msh = HL7::Message::Segment::MSH.new @base
      msh.enc_chars='^~\\&'
      msh.version_id.should eq '2.5'
      msh.country_code.should eq 'AU'
      msh.charset.should eq 'ASCII'
      msh.sending_responsible_org.should eq 'AN ORG'
      msh.receiving_network_address.should eq 'RECNET.ORG'
    end

    it 'allows creation of an MSH segment' do
      msh = HL7::Message::Segment::MSH.new
      msh.sending_facility="A Facility"
      msh.sending_facility.should eq 'A Facility'
      msh.time = DateTime.iso8601('20010203T040506')
      msh.time.should eq '20010203040506'
    end
  end
end
