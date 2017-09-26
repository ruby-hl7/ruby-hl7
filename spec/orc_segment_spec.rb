# encoding: UTF-8
$: << '../lib'
require 'ruby-hl7'

describe HL7::Message::Segment::ORC do
  context 'general' do
    before :all do
      @base_orc = 'ORC|RE|23456^EHR^2.16.840.1.113883.19.3.2.3^ISO|9700123^Lab^2.16.840.1.113883.19.3.1.6^ISO|||||||||1234^Admit^Alan^A^III^Dr^^^&2.16.840.1.113883.19.4.6^ISO^L^^^EI^&2.16.840.1.113883.19.4.6^ISO^^^^^^^^MD||^WPN^PH^^1^555^5551005|||||||Level Seven Healthcare, Inc.^L^^^^&2.16.840.1.113883.19.4.6^ISO^XX^^^1234|1005 Healthcare Drive^^Ann Arbor^MI^99999^USA^B|^WPN^PH^^1^555^5553001|4444 Healthcare Drive^Suite 123^Ann Arbor^MI^99999^USA^B|||||||7844'
    end

    it 'creates an ORC segment' do
      lambda do
        orc = HL7::Message::Segment::ORC.new( @base_orc )
        orc.should_not be_nil
        orc.to_s.should eq @base_orc
      end.should_not raise_error
    end

    it 'allows access to an ORC segment' do
      orc = HL7::Message::Segment::ORC.new( @base_orc )
      orc.ordering_provider.should eq '1234^Admit^Alan^A^III^Dr^^^&2.16.840.1.113883.19.4.6^ISO^L^^^EI^&2.16.840.1.113883.19.4.6^ISO^^^^^^^^MD'
      orc.call_back_phone_number.should eq '^WPN^PH^^1^555^5551005'
      orc.ordering_facility_name.should eq 'Level Seven Healthcare, Inc.^L^^^^&2.16.840.1.113883.19.4.6^ISO^XX^^^1234'
      orc.parent_universal_service_identifier.should eq '7844'
    end
  end
end
