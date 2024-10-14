require "spec_helper"

describe HL7::Message::Segment::OBX do
  context "general" do
    before :all do
      @base = "OBX|1|NM|30341-2^Erythrocyte sedimentation rate^LN^815117^ESR^99USI^^^Erythrocyte sedimentation rate||10|mm/h^millimeter per hour^UCUM|0 to 17|N|0.1||F|||20110331140551-0800||Observer|||20110331150551-0800|^A Site|||Century Hospital^^^^^NIST-AA-1&2.16.840.1.113883.3.72.5.30.1&ISO^XX^^^987|2070 Test Park^^Los Angeles^CA^90067^USA^B^^06037|2343242^Knowsalot^Phil^J.^III^Dr.^^^NIST-AA-1&2.16.840.1.113883.3.72.5.30.1&ISO^L^^^DN"
    end

    it "allows access to an OBX segment" do
      obx = HL7::Message::Segment::OBX.new @base
      expect(obx.set_id).to eq "1"
      expect(obx.value_type).to eq "NM"
      expect(obx.observation_id).to eq "30341-2^Erythrocyte sedimentation rate^LN^815117^ESR^99USI^^^Erythrocyte sedimentation rate"
      expect(obx.observation_sub_id).to eq ""
      expect(obx.observation_value).to eq "10"
      expect(obx.units).to eq "mm/h^millimeter per hour^UCUM"
      expect(obx.references_range).to eq "0 to 17"
      expect(obx.abnormal_flags).to eq "N"
      expect(obx.probability).to eq "0.1"
      expect(obx.nature_of_abnormal_test).to eq ""
      expect(obx.observation_result_status).to eq "F"
      expect(obx.effective_date_of_reference_range).to eq ""
      expect(obx.user_defined_access_checks).to eq ""
      expect(obx.observation_date).to eq "20110331140551-0800"
      expect(obx.producer_id).to eq ""
      expect(obx.responsible_observer).to eq "Observer"
      expect(obx.observation_site).to eq "^A Site"
      expect(obx.observation_method).to eq ""
      expect(obx.equipment_instance_id).to eq ""
      expect(obx.analysis_date).to eq "20110331150551-0800"
      expect(obx.performing_organization_name).to eq "Century Hospital^^^^^NIST-AA-1&2.16.840.1.113883.3.72.5.30.1&ISO^XX^^^987"
      expect(obx.performing_organization_address).to eq "2070 Test Park^^Los Angeles^CA^90067^USA^B^^06037"
      expect(obx.performing_organization_medical_director).to eq "2343242^Knowsalot^Phil^J.^III^Dr.^^^NIST-AA-1&2.16.840.1.113883.3.72.5.30.1&ISO^L^^^DN"
    end

    it "allows creation of an OBX segment" do
      expect do
        obx = HL7::Message::Segment::OBX.new
        obx.value_type = "TESTIES"
        obx.observation_id = "HR"
        obx.observation_sub_id = "2"
        obx.observation_value = "SOMETHING HAPPENned"
      end.not_to raise_error
    end

    describe "#correction?" do
      subject { obx.correction? }

      let(:obx) { HL7::Message::Segment::OBX.new data }

      context "when is a correction" do
        let(:data) do
          "OBX|1|ST|123456^AA OBSERVATION^L^4567890^FIRST OBSERVATION^LN||42|ug/dL^Micrograms per Deciliter^UCUM|<10 ug/dL|H|||C||||OMG"
        end

        it { is_expected.to be true }
      end

      context "when is not a correction" do
        let(:data) do
          "OBX|1|ST|123456^AA OBSERVATION^L^4567890^FIRST OBSERVATION^LN||42|ug/dL^Micrograms per Deciliter^UCUM|<10 ug/dL|H|||F||||OMG"
        end

        it { is_expected.to be false }
      end
    end
  end
end
