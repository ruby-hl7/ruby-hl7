require "spec_helper"

describe HL7::Message::Segment::PID do
  let(:segment) do
    "PID|1||333||LastName^FirstName^MiddleInitial^SR^NickName||19760228|F||2106-3^White^HL70005^CAUC^Caucasian^L||AA||||||555.55|012345678||||||||||201011110924-0700|Y||UA|||||||"
  end
  let(:filled_pid) { HL7::Message::Segment::PID.new(segment) }

  describe ".initialize" do
    it "sets values correctly" do
      expect(filled_pid.set_id).to eq "1"
      expect(filled_pid.patient_id).to eq ""
      expect(filled_pid.patient_id_list).to eq "333"
      expect(filled_pid.alt_patient_id).to eq ""
      expect(filled_pid.patient_name).to eq "LastName^FirstName^MiddleInitial^SR^NickName"
      expect(filled_pid.mother_maiden_name).to eq ""
      expect(filled_pid.patient_dob).to eq "19760228"
      expect(filled_pid.admin_sex).to eq "F"
      expect(filled_pid.patient_alias).to eq ""
      expect(filled_pid.race).to eq "2106-3^White^HL70005^CAUC^Caucasian^L"
      expect(filled_pid.address).to eq ""
      expect(filled_pid.county_code).to eq "AA"
      expect(filled_pid.phone_home).to eq ""
      expect(filled_pid.phone_business).to eq ""
      expect(filled_pid.primary_language).to eq ""
      expect(filled_pid.marital_status).to eq ""
      expect(filled_pid.religion).to eq ""
      expect(filled_pid.account_number).to eq "555.55"
      expect(filled_pid.social_security_num).to eq "012345678"
      expect(filled_pid.driver_license_num).to eq ""
      expect(filled_pid.mothers_id).to eq ""
      expect(filled_pid.ethnic_group).to eq ""
      expect(filled_pid.birthplace).to eq ""
      expect(filled_pid.multi_birth).to eq ""
      expect(filled_pid.birth_order).to eq ""
      expect(filled_pid.citizenship).to eq ""
      expect(filled_pid.vet_status).to eq ""
      expect(filled_pid.nationality).to eq ""
      expect(filled_pid.death_date).to eq "201011110924-0700"
      expect(filled_pid.death_indicator).to eq "Y"
      expect(filled_pid.id_unknown_indicator).to eq ""
      expect(filled_pid.id_reliability_code).to eq "UA"
      expect(filled_pid.last_update_date).to eq ""
      expect(filled_pid.last_update_facility).to eq ""
      expect(filled_pid.species_code).to eq ""
      expect(filled_pid.breed_code).to eq ""
      expect(filled_pid.strain).to eq ""
      expect(filled_pid.production_class_code).to eq ""
      expect(filled_pid.tribal_citizenship).to eq ""
    end
  end

  describe "#country_code" do
    it "aliases the county_code field as country_code for backward compatibility" do
      expect(filled_pid.country_code).to eq "AA"

      filled_pid.country_code = "ZZ"
      expect(filled_pid.country_code).to eq "ZZ"
    end
  end

  describe "#id_readability_code=" do
    it "aliases the id_reliability_code field as id_readability_code for backward compatibility" do
      expect(filled_pid.id_readability_code).to eq "UA"

      filled_pid.id_readability_code = "AL"
      expect(filled_pid.id_reliability_code).to eq "AL"
    end
  end

  describe "#admin_sex=" do
    context "when admin_sex is filled with an invalid value" do
      it "raises an InvalidDataError" do
        expect do
          ["TEST", "A", 1, 2].each do |x|
            filled_pid.admin_sex = x
          end
        end.to raise_error(HL7::InvalidDataError)
      end
    end

    context "when admin_sex is filled with a valid value" do
      it "does not raise any error" do
        expect do
          vals = %w[F M O U A N] + [nil]
          vals.each do |x|
            filled_pid.admin_sex = x
          end
          filled_pid.admin_sex = ""
        end.not_to raise_error
      end
    end
  end
end
