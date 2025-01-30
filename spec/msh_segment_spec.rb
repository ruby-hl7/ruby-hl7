# frozen_string_literal: true

require "spec_helper"

describe HL7::Message::Segment::MSH do
  describe "segment parsing" do
    let(:segment_string) do
      "MSH|^~\\&||ABCHS||AUSDHSV|20070101112951||ADT^A04^ADT_A01|12334456778890|P|2.5|||NE|NE|AU|ASCII|ENGLISH|||AN ORG|||RECNET.ORG"
    end
    let(:filled_msh) { HL7::Message::Segment::MSH.new(segment_string) }

    it "allows access to an MSH segment's attributes by their getters" do
      expect(filled_msh.enc_chars).to eq("^~\\&")
      expect(filled_msh.sending_app).to eq("")
      expect(filled_msh.sending_facility).to eq("ABCHS")
      expect(filled_msh.recv_app).to eq("")
      expect(filled_msh.recv_facility).to eq("AUSDHSV")
      expect(filled_msh.time).to eq("20070101112951")
      expect(filled_msh.security).to eq("")
      expect(filled_msh.message_type).to eq("ADT^A04^ADT_A01")
      expect(filled_msh.message_control_id).to eq("12334456778890")
      expect(filled_msh.processing_id).to eq("P")
      expect(filled_msh.version_id).to eq("2.5")
      expect(filled_msh.seq).to eq("")
      expect(filled_msh.continue_ptr).to eq("")
      expect(filled_msh.accept_ack_type).to eq("NE")
      expect(filled_msh.app_ack_type).to eq("NE")
      expect(filled_msh.country_code).to eq("AU")
      expect(filled_msh.charset).to eq("ASCII")
      expect(filled_msh.principal_language_of_message).to eq("ENGLISH")
      expect(filled_msh.alternate_character_set_handling_scheme).to eq("")
      expect(filled_msh.message_profile_identifier).to eq("")
      expect(filled_msh.sending_responsible_org).to eq("AN ORG")
      expect(filled_msh.receiving_responsible_org).to eq("")
      expect(filled_msh.sending_network_address).to eq("")
      expect(filled_msh.receiving_network_address).to eq("RECNET.ORG")
    end

    it "allows access to an MSH segment's attributes by their index" do
      expect(filled_msh[2]).to eq("^~\\&")
      expect(filled_msh[3]).to eq("")
      expect(filled_msh[4]).to eq("ABCHS")
      expect(filled_msh[5]).to eq("")
      expect(filled_msh[6]).to eq("AUSDHSV")
      expect(filled_msh[7]).to eq("20070101112951")
      expect(filled_msh[8]).to eq("")
      expect(filled_msh[9]).to eq("ADT^A04^ADT_A01")
      expect(filled_msh[10]).to eq("12334456778890")
      expect(filled_msh[11]).to eq("P")
      expect(filled_msh[12]).to eq("2.5")
      expect(filled_msh[13]).to eq("")
      expect(filled_msh[14]).to eq("")
      expect(filled_msh[15]).to eq("NE")
      expect(filled_msh[16]).to eq("NE")
      expect(filled_msh[17]).to eq("AU")
      expect(filled_msh[18]).to eq("ASCII")
      expect(filled_msh[19]).to eq("ENGLISH")
      expect(filled_msh[20]).to eq("")
      expect(filled_msh[21]).to eq("")
      expect(filled_msh[22]).to eq("AN ORG")
      expect(filled_msh[23]).to eq("")
      expect(filled_msh[24]).to eq("")
      expect(filled_msh[25]).to eq("RECNET.ORG")
    end
  end

  describe "segment creation" do
    let(:msh) { HL7::Message::Segment::MSH.new }
    let(:expected_msh_string) do
      "MSH|^~\\&||ABCHS||AUSDHSV|20070101112951||ADT^A04^ADT_A01|12334456778890|P|2.5|||NE|NE|AU|ASCII|ENGLISH|||AN ORG|||RECNET.ORG"
    end

    before do
      msh.enc_chars = "^~\\&"
      msh.sending_app = ""
      msh.sending_facility = "ABCHS"
      msh.recv_app = ""
      msh.recv_facility = "AUSDHSV"
      msh.time = "20070101112951"
      msh.security = ""
      msh.message_type = "ADT^A04^ADT_A01"
      msh.message_control_id = "12334456778890"
      msh.processing_id = "P"
      msh.version_id = "2.5"
      msh.seq = ""
      msh.continue_ptr = ""
      msh.accept_ack_type = "NE"
      msh.app_ack_type = "NE"
      msh.country_code = "AU"
      msh.charset = "ASCII"
      msh.principal_language_of_message = "ENGLISH"
      msh.alternate_character_set_handling_scheme = ""
      msh.message_profile_identifier = ""
      msh.sending_responsible_org = "AN ORG"
      msh.receiving_responsible_org = ""
      msh.sending_network_address = ""
      msh.receiving_network_address = "RECNET.ORG"
    end

    it "serializes an MSH segment" do
      expect(msh.to_s).to eq(expected_msh_string)
    end
  end
end
