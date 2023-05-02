$LOAD_PATH << '../lib'
require 'ruby-hl7'

describe HL7::Message::Segment::ORC do
  context 'general' do
    before :all do
      @base_orc = 'ORC|RE|23456^EHR^2.16.840.1.113883.19.3.2.3^ISO|9700123^Lab^2.16.840.1.113883.19.3.1.6^ISO|||||||||1234^Admit^Alan^A^III^Dr^^^&2.16.840.1.113883.19.4.6^ISO^L^^^EI^&2.16.840.1.113883.19.4.6^ISO^^^^^^^^MD||^WPN^PH^^1^555^5551005|||||||Level Seven Healthcare, Inc.^L^^^^&2.16.840.1.113883.19.4.6^ISO^XX^^^1234|1005 Healthcare Drive^^Ann Arbor^MI^99999^USA^B|^WPN^PH^^1^555^5553001|4444 Healthcare Drive^Suite 123^Ann Arbor^MI^99999^USA^B|||||||7844'
    end

    it 'creates an ORC segment' do
      expect do
        orc = described_class.new(@base_orc)
        expect(orc).not_to be_nil
        expect(orc.to_s).to eq @base_orc
      end.not_to raise_error
    end

    it 'allows access to an ORC segment' do
      orc = described_class.new(@base_orc)
      expect(orc.ordering_provider).to eq '1234^Admit^Alan^A^III^Dr^^^&2.16.840.1.113883.19.4.6^ISO^L^^^EI^&2.16.840.1.113883.19.4.6^ISO^^^^^^^^MD'
      expect(orc.call_back_phone_number).to eq '^WPN^PH^^1^555^5551005'
      expect(orc.ordering_facility_name).to eq 'Level Seven Healthcare, Inc.^L^^^^&2.16.840.1.113883.19.4.6^ISO^XX^^^1234'
      expect(orc.parent_universal_service_identifier).to eq '7844'
    end
  end
end
