require "spec_helper"

describe HL7::Message do
  describe "#correction?" do
    subject { hl7.correction? }

    let(:hl7) { HL7::Message.new data }

    context "when is a correction" do
      let(:data) do
        [
          "OBR|1|A241Z^LAB||123456^A TEST^L|||201508181431||1234||||None|201502181432||||OMG123||||20150818143300",         # "F" final
          "OBX|1|ST|123456^AA OBSERVATION^L^4567890^FIRST OBSERVATION^LN||42|ug/dL^Micrograms per Deciliter^UCUM|<10 ug/dL|H|||F||||OMG",
          "NTE|1||SOME",
          "NTE|2||THOUGHTS",
          "OBR|2|A241Z^LAB||123456^A TEST^L|||201508181431||1234||||None|201502181432||||OMG123||||20150818143300",         # "C" corrected
          "OBX|1|ST|123456^AA OBSERVATION^L^4567890^FIRST OBSERVATION^LN||42|ug/dL^Micrograms per Deciliter^UCUM|<10 ug/dL|H|||C||||OMG",
          "NTE|1||SOME",
          "NTE|2||THOUGHTS",
        ].join("\r")
      end

      it { is_expected.to be true }
    end

    context "when is not a correction" do
      let(:data) do
        [
          "OBR|1|A241Z^LAB||123456^A TEST^L|||201508181431||1234||||None|201502181432||||OMG123||||20150818143300",         # "F" final
          "OBX|1|ST|123456^AA OBSERVATION^L^4567890^FIRST OBSERVATION^LN||42|ug/dL^Micrograms per Deciliter^UCUM|<10 ug/dL|H|||F||||OMG",
          "NTE|1||SOME",
          "NTE|2||THOUGHTS",
          "OBR|2|A241Z^LAB||123456^A TEST^L|||201508181431||1234||||None|201502181432||||OMG123||||20150818143300",         # "F" final
          "OBX|1|ST|123456^AA OBSERVATION^L^4567890^FIRST OBSERVATION^LN||42|ug/dL^Micrograms per Deciliter^UCUM|<10 ug/dL|H|||F||||OMG",
          "NTE|1||SOME",
          "NTE|2||THOUGHTS",
        ].join("\r")
      end

      it { is_expected.to be false }
    end

    context "when there are no results (OBX) segments" do
      let(:data) do
        [
          "OBR|1|A241Z^LAB||123456^A TEST^L|||201508181431||1234||||None|201502181432||||OMG123||||20150818143300",
          "OBR|2|A241Z^LAB||123456^A TEST^L|||201508181431||1234||||None|201502181432||||OMG123||||20150818143300",
        ].join("\r")
      end

      it { is_expected.to be false }
    end
  end
end
