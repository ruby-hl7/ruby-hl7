# frozen_string_literal: true

require "spec_helper"

describe HL7::Message::Segment::PRT do
  describe "segment parsing" do
    let(:segment_string) do
      "PRT|1^N01^1^UUID|AD|Reason|AP|1^Author|Provider type|1|" \
        "ORG^A||2^N01^2^UUID|20240611|20240711|Duration|" \
        "2070 Test Park^^Los Angeles^CA^90067^USA^B^^06037|^ASN^CP"
    end
    let(:filled_prt) { HL7::Message::Segment::PRT.new(segment_string) }

    it "allows access to a PRT segment's attributes" do
      expect(filled_prt.participation_instance_id).to eq("1^N01^1^UUID")
      expect(filled_prt.action_code).to eq("AD")
      expect(filled_prt.action_reason).to eq("Reason")
      expect(filled_prt.participation).to eq("AP")
      expect(filled_prt.participation_person).to eq("1^Author")
      expect(filled_prt.participation_person_provider_type).to eq("Provider type")
      expect(filled_prt.participation_organization_unit_type).to eq("1")
      expect(filled_prt.participation_organization).to eq("ORG^A")
      expect(filled_prt.participation_location).to eq("")
      expect(filled_prt.participation_device).to eq("2^N01^2^UUID")
      expect(filled_prt.participation_begin_date_time).to eq("20240611")
      expect(filled_prt.participation_end_date_time).to eq("20240711")
      expect(filled_prt.participation_qualitative_duration).to eq("Duration")
      expect(filled_prt.participation_address).to eq("2070 Test Park^^Los Angeles^CA^90067^USA^B^^06037")
      expect(filled_prt.participation_telecommunication_address).to eq("^ASN^CP")
    end
  end

  describe "segment creation" do
    let(:prt) { HL7::Message::Segment::PRT.new }
    let(:expected_segment_string) do
      "PRT|1^N01^1^UUID|AD|Reason|AP|1^Author|Provider type|1|" \
        "ORG^A||2^N01^2^UUID|20240611|20240711|Duration|" \
        "2070 Test Park^^Los Angeles^CA^90067^USA^B^^06037|^ASN^CP"
    end

    before do
      prt.participation_instance_id = "1^N01^1^UUID"
      prt.action_code = "AD"
      prt.action_reason = "Reason"
      prt.participation = "AP"
      prt.participation_person = "1^Author"
      prt.participation_person_provider_type = "Provider type"
      prt.participation_organization_unit_type = "1"
      prt.participation_organization = "ORG^A"
      prt.participation_location = ""
      prt.participation_device = "2^N01^2^UUID"
      prt.participation_begin_date_time = "20240611"
      prt.participation_end_date_time = "20240711"
      prt.participation_qualitative_duration = "Duration"
      prt.participation_address = "2070 Test Park^^Los Angeles^CA^90067^USA^B^^06037"
      prt.participation_telecommunication_address = "^ASN^CP"
    end

    it "serializes a PRT segment" do
      expect(prt.to_s).to eq(expected_segment_string)
    end
  end
end
