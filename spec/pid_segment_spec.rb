# encoding: UTF-8
require 'spec_helper'

describe HL7::Message::Segment::PID do
  context 'general' do
    before :all do
      @base = "PID|1||333||LastName^FirstName^MiddleInitial^SR^NickName||19760228|F||2106-3^White^HL70005^CAUC^Caucasian^L||AA||||||555.55|012345678||||||||||201011110924-0700|Y|||||||||"
    end

    it 'validates the admin_sex element' do
      pid = HL7::Message::Segment::PID.new
      expect do
        vals = %w[F M O U A N C] + [ nil ]
        vals.each do |x|
          pid.admin_sex = x
        end
        pid.admin_sex = ""
      end.not_to raise_error

      expect do
        ["TEST", "A", 1, 2].each do |x|
          pid.admin_sex = x
        end
      end.to raise_error(HL7::InvalidDataError)
    end

    it "sets values correctly" do
      pid = HL7::Message::Segment::PID.new @base
      expect(pid.set_id).to eq "1"
      expect(pid.patient_id).to eq ""
      expect(pid.patient_id_list).to eq "333"
      expect(pid.alt_patient_id).to eq ""
      expect(pid.patient_name).to eq "LastName^FirstName^MiddleInitial^SR^NickName"
      expect(pid.mother_maiden_name).to eq ""
      expect(pid.patient_dob).to eq "19760228"
      expect(pid.admin_sex).to eq "F"
      expect(pid.patient_alias).to eq ""
      expect(pid.race).to eq "2106-3^White^HL70005^CAUC^Caucasian^L"
      expect(pid.address).to eq ""
      expect(pid.county_code).to eq "AA"
      expect(pid.phone_home).to eq ""
      expect(pid.phone_business).to eq ""
      expect(pid.primary_language).to eq ""
      expect(pid.marital_status).to eq ""
      expect(pid.religion).to eq ""
      expect(pid.account_number).to eq "555.55"
      expect(pid.social_security_num).to eq "012345678"
      expect(pid.driver_license_num).to eq ""
      expect(pid.mothers_id).to eq ""
      expect(pid.ethnic_group).to eq ""
      expect(pid.birthplace).to eq ""
      expect(pid.multi_birth).to eq ""
      expect(pid.birth_order).to eq ""
      expect(pid.citizenship).to eq ""
      expect(pid.vet_status).to eq ""
      expect(pid.nationality).to eq ""
      expect(pid.death_date).to eq "201011110924-0700"
      expect(pid.death_indicator).to eq "Y"
      expect(pid.id_unknown_indicator).to eq ""
      expect(pid.id_readability_code).to eq ""
      expect(pid.last_update_date).to eq ""
      expect(pid.last_update_facility).to eq ""
      expect(pid.species_code).to eq ""
      expect(pid.breed_code).to eq ""
      expect(pid.strain).to eq ""
      expect(pid.production_class_code).to eq ""
      expect(pid.tribal_citizenship).to eq ""
    end

    it "aliases the county_code field as country_code for backwards compatibility" do
      pid = HL7::Message::Segment::PID.new @base
      expect(pid.country_code).to eq "AA"

      pid.country_code = "ZZ"
      expect(pid.country_code).to eq "ZZ"
    end
  end
end
