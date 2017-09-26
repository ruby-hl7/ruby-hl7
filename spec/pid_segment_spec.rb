# encoding: UTF-8
require 'spec_helper'

describe HL7::Message::Segment::PID do
  context 'general' do
    before :all do
      @base = "PID|1||333||LastName^FirstName^MiddleInitial^SR^NickName||19760228|F||2106-3^White^HL70005^CAUC^Caucasian^L||||||||555.55|012345678||||||||||201011110924-0700|Y|||||||||"
    end

    it 'validates the admin_sex element' do
      pid = HL7::Message::Segment::PID.new
      lambda do
        vals = %w[F M O U A N C] + [ nil ]
        vals.each do |x|
          pid.admin_sex = x
        end
        pid.admin_sex = ""
      end.should_not raise_error

      lambda do
        ["TEST", "A", 1, 2].each do |x|
          pid.admin_sex = x
        end
      end.should raise_error(HL7::InvalidDataError)
    end

    it "sets values correctly" do
      pid = HL7::Message::Segment::PID.new @base
      pid.set_id.should eq "1"
      pid.patient_id.should eq ""
      pid.patient_id_list.should eq "333"
      pid.alt_patient_id.should eq ""
      pid.patient_name.should eq "LastName^FirstName^MiddleInitial^SR^NickName"
      pid.mother_maiden_name.should eq ""
      pid.patient_dob.should eq "19760228"
      pid.admin_sex.should eq "F"
      pid.patient_alias.should eq ""
      pid.race.should eq "2106-3^White^HL70005^CAUC^Caucasian^L"
      pid.address.should eq ""
      pid.country_code.should eq ""
      pid.phone_home.should eq ""
      pid.phone_business.should eq ""
      pid.primary_language.should eq ""
      pid.marital_status.should eq ""
      pid.religion.should eq ""
      pid.account_number.should eq "555.55"
      pid.social_security_num.should eq "012345678"
      pid.driver_license_num.should eq ""
      pid.mothers_id.should eq ""
      pid.ethnic_group.should eq ""
      pid.birthplace.should eq ""
      pid.multi_birth.should eq ""
      pid.birth_order.should eq ""
      pid.citizenship.should eq ""
      pid.vet_status.should eq ""
      pid.nationality.should eq ""
      pid.death_date.should eq "201011110924-0700"
      pid.death_indicator.should eq "Y"
      pid.id_unknown_indicator.should eq ""
      pid.id_readability_code.should eq ""
      pid.last_update_date.should eq ""
      pid.last_update_facility.should eq ""
      pid.species_code.should eq ""
      pid.breed_code.should eq ""
      pid.strain.should eq ""
      pid.production_class_code.should eq ""
      pid.tribal_citizenship.should eq ""
    end
  end
end
