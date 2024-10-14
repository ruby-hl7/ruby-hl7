require "spec_helper"

describe HL7::Message::Segment::MSH do
  context "general" do
    before :all do
      @base = "MSH|^~\\&||ABCHS||AUSDHSV|20070101112951||ADT^A04^ADT_A01|12334456778890|P|2.5|||NE|NE|AU|ASCII|ENGLISH|||AN ORG|||RECNET.ORG"
    end

    it "allows access to an MSH segment" do
      msh = HL7::Message::Segment::MSH.new @base
      msh.enc_chars = '^~\\&'
      expect(msh.version_id).to eq "2.5"
      expect(msh.country_code).to eq "AU"
      expect(msh.charset).to eq "ASCII"
      expect(msh.sending_responsible_org).to eq "AN ORG"
      expect(msh.receiving_network_address).to eq "RECNET.ORG"
    end

    it "allows creation of an MSH segment" do
      msh = HL7::Message::Segment::MSH.new
      msh.sending_facility = "A Facility"
      expect(msh.sending_facility).to eq "A Facility"
      msh.time = DateTime.iso8601("20010203T040506")
      expect(msh.time).to eq "20010203040506"
    end
  end
end
