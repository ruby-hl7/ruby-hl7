# frozen_string_literal: true

require "spec_helper"

# rubocop:disable RSpec/MultipleExpectations, RSpec/ExampleLength
# reason: we need to assert every segment field to be exhaustive
describe HL7::Message::Segment::NK1 do
  let(:segment_string) do
    "NK1|1|Mum^Martha^M^^^^L|MTH^Mother^HL70063^^^^2.5.1|444 Home Street^Apt B^Ann Arbor^MI^99999^USA^H" \
      "|5555552006|5555552007|EMC^Emergency Contact^HL70131|20011105|20011209|job_title|job_code|employee_number" \
      "|organization_name|marital_status|F|20011209|living_dependency|ambulatory_status|citizenship" \
      "|primary_language|living_arrangement|publicity_code|protection_indicator|student_indicator|religion" \
      "|mother_maiden_name|nationality|ethnic_group|contact_reason|contact_persons_name|contact_persons_telephone_number" \
      "|contact_persons_address|identifiers|job_status|race|handicap|contact_persons_ssn|birth_place|vip_indicator" \
      "|telecommunication_information|contact_persons_telecommunication_information"
  end
  let(:filled_nk1) { HL7::Message::Segment::NK1.new(segment_string) }

  describe "segment parsing" do
    it "allows access to an NK1 segment's attributes" do
      expect(filled_nk1.set_id).to eq "1"
      expect(filled_nk1.name).to eq "Mum^Martha^M^^^^L"
      expect(filled_nk1.relationship).to eq "MTH^Mother^HL70063^^^^2.5.1"
      expect(filled_nk1.address).to eq "444 Home Street^Apt B^Ann Arbor^MI^99999^USA^H"
      expect(filled_nk1.phone_number).to eq "5555552006"
      expect(filled_nk1.business_phone_number).to eq "5555552007"
      expect(filled_nk1.contact_role).to eq "EMC^Emergency Contact^HL70131"
      expect(filled_nk1.start_date).to eq "20011105"
      expect(filled_nk1.end_date).to eq "20011209"
      expect(filled_nk1.job_title).to eq "job_title"
      expect(filled_nk1.job_code).to eq "job_code"
      expect(filled_nk1.employee_number).to eq "employee_number"
      expect(filled_nk1.organization_name).to eq "organization_name"
      expect(filled_nk1.marital_status).to eq "marital_status"
      expect(filled_nk1.admin_sex).to eq "F"
      expect(filled_nk1.date_of_birth).to eq "20011209"
      expect(filled_nk1.living_dependency).to eq "living_dependency"
      expect(filled_nk1.ambulatory_status).to eq "ambulatory_status"
      expect(filled_nk1.citizenship).to eq "citizenship"
      expect(filled_nk1.primary_language).to eq "primary_language"
      expect(filled_nk1.living_arrangement).to eq "living_arrangement"
      expect(filled_nk1.publicity_code).to eq "publicity_code"
      expect(filled_nk1.protection_indicator).to eq "protection_indicator"
      expect(filled_nk1.student_indicator).to eq "student_indicator"
      expect(filled_nk1.religion).to eq "religion"
      expect(filled_nk1.mother_maiden_name).to eq "mother_maiden_name"
      expect(filled_nk1.nationality).to eq "nationality"
      expect(filled_nk1.ethnic_group).to eq "ethnic_group"
      expect(filled_nk1.contact_reason).to eq "contact_reason"
      expect(filled_nk1.contact_persons_name).to eq "contact_persons_name"
      expect(filled_nk1.contact_persons_telephone_number).to eq "contact_persons_telephone_number"
      expect(filled_nk1.contact_persons_address).to eq "contact_persons_address"
      expect(filled_nk1.identifiers).to eq "identifiers"
      expect(filled_nk1.job_status).to eq "job_status"
      expect(filled_nk1.race).to eq "race"
      expect(filled_nk1.handicap).to eq "handicap"
      expect(filled_nk1.contact_persons_ssn).to eq "contact_persons_ssn"
      expect(filled_nk1.birth_place).to eq "birth_place"
      expect(filled_nk1.vip_indicator).to eq "vip_indicator"
      expect(filled_nk1.telecommunication_information).to eq "telecommunication_information"
      expect(filled_nk1.contact_persons_telecommunication_information).to eq "contact_persons_telecommunication_information"
    end
  end

  describe "segment creation" do
    let(:nk1) { HL7::Message::Segment::NK1.new }

    before do
      nk1.set_id = "1"
      nk1.name = "Mum^Martha^M^^^^L"
      nk1.relationship = "MTH^Mother^HL70063^^^^2.5.1"
      nk1.address = "444 Home Street^Apt B^Ann Arbor^MI^99999^USA^H"
      nk1.phone_number = "5555552006"
      nk1.business_phone_number = "5555552007"
      nk1.contact_role = "EMC^Emergency Contact^HL70131"
      nk1.start_date = "20011105"
      nk1.end_date = "20011209"
      nk1.job_title = "job_title"
      nk1.job_code = "job_code"
      nk1.employee_number = "employee_number"
      nk1.organization_name = "organization_name"
      nk1.marital_status = "marital_status"
      nk1.admin_sex = "F"
      nk1.date_of_birth = "20011209"
      nk1.living_dependency = "living_dependency"
      nk1.ambulatory_status = "ambulatory_status"
      nk1.citizenship = "citizenship"
      nk1.primary_language = "primary_language"
      nk1.living_arrangement = "living_arrangement"
      nk1.publicity_code = "publicity_code"
      nk1.protection_indicator = "protection_indicator"
      nk1.student_indicator = "student_indicator"
      nk1.religion = "religion"
      nk1.mother_maiden_name = "mother_maiden_name"
      nk1.nationality = "nationality"
      nk1.ethnic_group = "ethnic_group"
      nk1.contact_reason = "contact_reason"
      nk1.contact_persons_name = "contact_persons_name"
      nk1.contact_persons_telephone_number = "contact_persons_telephone_number"
      nk1.contact_persons_address = "contact_persons_address"
      nk1.identifiers = "identifiers"
      nk1.job_status = "job_status"
      nk1.race = "race"
      nk1.handicap = "handicap"
      nk1.contact_persons_ssn = "contact_persons_ssn"
      nk1.birth_place = "birth_place"
      nk1.vip_indicator = "vip_indicator"
      nk1.telecommunication_information = "telecommunication_information"
      nk1.contact_persons_telecommunication_information = "contact_persons_telecommunication_information"
    end

    it "serializes an NK1 segment" do
      expect(nk1.to_s).to eq(segment_string)
    end
  end

  describe "#admin_sex=" do
    context "when admin_sex is filled with an invalid value" do
      it "raises an InvalidDataError" do
        expect do
          ["TEST", "A", 1, 2].each do |x|
            filled_nk1.admin_sex = x
          end
        end.to raise_error(HL7::InvalidDataError)
      end
    end

    context "when admin_sex is filled with a valid value" do
      it "does not raise any error" do
        expect do
          vals = %w[F M O U A N] + [nil]
          vals.each do |x|
            filled_nk1.admin_sex = x
          end
          filled_nk1.admin_sex = ""
        end.not_to raise_error
      end
    end
  end
end
# rubocop:enable RSpec/MultipleExpectations, RSpec/ExampleLength
