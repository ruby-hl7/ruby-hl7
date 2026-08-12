# frozen_string_literal: true

require "spec_helper"

describe HL7::Message::Segment::ROL do
  describe "segment parsing" do
    let(:segment_string) do
      "ROL|1|AD|Role|Role person|20240611|20240711|Duration|Role action reason|Provider type|Organization unit type|Office home address birthplace|Phone number|Person location|Organization"
    end
    let(:filled_rol) { HL7::Message::Segment::ROL.new(segment_string) }

    it "allows access to a ROL segment's attributes" do
      expect(filled_rol.role_instance).to eq("1")
      expect(filled_rol.action_code).to eq("AD")
      expect(filled_rol.role).to eq("Role")
      expect(filled_rol.role_person).to eq("Role person")
      expect(filled_rol.role_begin_date_time).to eq("20240611")
      expect(filled_rol.role_end_date_time).to eq("20240711")
      expect(filled_rol.role_duration).to eq("Duration")
      expect(filled_rol.role_action_reason).to eq("Role action reason")
      expect(filled_rol.provider_type).to eq("Provider type")
      expect(filled_rol.organization_unit_type).to eq("Organization unit type")
      expect(filled_rol.office_home_address_birthplace).to eq("Office home address birthplace")
      expect(filled_rol.phone_number).to eq("Phone number")
      expect(filled_rol.person_location).to eq("Person location")
      expect(filled_rol.organization).to eq("Organization")
    end
  end

  describe "segment creation" do
    let(:rol) { HL7::Message::Segment::ROL.new }
    let(:expected_segment_string) do
      "ROL|1|AD|Role|Role person|20240611|20240711|Duration|Role action reason|Provider type|Organization unit type|Office home address birthplace|Phone number|Person location|Organization"
    end

    before do
      rol.role_instance = "1"
      rol.action_code = "AD"
      rol.role = "Role"
      rol.role_person = "Role person"
      rol.role_begin_date_time = "20240611"
      rol.role_end_date_time = "20240711"
      rol.role_duration = "Duration"
      rol.role_action_reason = "Role action reason"
      rol.provider_type = "Provider type"
      rol.organization_unit_type = "Organization unit type"
      rol.office_home_address_birthplace = "Office home address birthplace"
      rol.phone_number = "Phone number"
      rol.person_location = "Person location"
      rol.organization = "Organization"
    end

    it "serializes a ROL segment" do
      expect(rol.to_s).to eq(expected_segment_string)
    end
  end
end
