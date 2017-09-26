# encoding: UTF-8
require 'spec_helper'

describe HL7::Message::Segment::OBX do
  context 'general' do
    before :all do
      @base = "OBX|1|NM|30341-2^Erythrocyte sedimentation rate^LN^815117^ESR^99USI^^^Erythrocyte sedimentation rate||10|mm/h^millimeter per hour^UCUM|0 to 17|N|0.1||F|||20110331140551-0800||Observer|||20110331150551-0800|^A Site|||Century Hospital^^^^^NIST-AA-1&2.16.840.1.113883.3.72.5.30.1&ISO^XX^^^987|2070 Test Park^^Los Angeles^CA^90067^USA^B^^06037|2343242^Knowsalot^Phil^J.^III^Dr.^^^NIST-AA-1&2.16.840.1.113883.3.72.5.30.1&ISO^L^^^DN"
    end

    it 'allows access to an OBX segment' do
      obx = HL7::Message::Segment::OBX.new @base
      obx.set_id.should eq "1"
      obx.value_type.should eq "NM"
      obx.observation_id.should eq "30341-2^Erythrocyte sedimentation rate^LN^815117^ESR^99USI^^^Erythrocyte sedimentation rate"
      obx.observation_sub_id.should eq ""
      obx.observation_value.should eq "10"
      obx.units.should eq "mm/h^millimeter per hour^UCUM"
      obx.references_range.should eq "0 to 17"
      obx.abnormal_flags.should eq "N"
      obx.probability.should eq "0.1"
      obx.nature_of_abnormal_test.should eq ""
      obx.observation_result_status.should eq "F"
      obx.effective_date_of_reference_range.should eq ""
      obx.user_defined_access_checks.should eq ""
      obx.observation_date.should eq "20110331140551-0800"
      obx.producer_id.should eq ""
      obx.responsible_observer.should eq "Observer"
      obx.observation_site.should eq '^A Site'
      obx.observation_method.should eq ""
      obx.equipment_instance_id.should eq ""
      obx.analysis_date.should eq "20110331150551-0800"
      obx.performing_organization_name.should eq "Century Hospital^^^^^NIST-AA-1&2.16.840.1.113883.3.72.5.30.1&ISO^XX^^^987"
      obx.performing_organization_address.should eq "2070 Test Park^^Los Angeles^CA^90067^USA^B^^06037"
      obx.performing_organization_medical_director.should eq "2343242^Knowsalot^Phil^J.^III^Dr.^^^NIST-AA-1&2.16.840.1.113883.3.72.5.30.1&ISO^L^^^DN"
    end

    it 'allows creation of an OBX segment' do
      lambda do
        obx = HL7::Message::Segment::OBX.new
        obx.value_type = "TESTIES"
        obx.observation_id = "HR"
        obx.observation_sub_id = "2"
        obx.observation_value = "SOMETHING HAPPENned"
      end.should_not raise_error
    end

    describe "#correction?" do
      let(:obx) { HL7::Message::Segment::OBX.new data  }
      subject { obx.correction? }

      context "when is a correction" do
        let(:data) {
          'OBX|1|ST|123456^AA OBSERVATION^L^4567890^FIRST OBSERVATION^LN||42|ug/dL^Micrograms per Deciliter^UCUM|<10 ug/dL|H|||C||||OMG'
        }

        it { is_expected.to be true }
      end

      context "when is not a correction" do
        let(:data) {
          'OBX|1|ST|123456^AA OBSERVATION^L^4567890^FIRST OBSERVATION^LN||42|ug/dL^Micrograms per Deciliter^UCUM|<10 ug/dL|H|||F||||OMG'
        }

        it { is_expected.to be false }
      end
    end
  end
end
