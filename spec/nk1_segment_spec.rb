# encoding: UTF-8
require 'spec_helper'

describe HL7::Message::Segment::NK1 do
  context 'general' do
    before :all do
      @base_nk1 = 'NK1|1|Mum^Martha^M^^^^L|MTH^Mother^HL70063^^^^2.5.1| 444 Home Street^Apt B^Ann Arbor^MI^99999^USA^H|^PRN^PH^^1^555^5552006'
    end

    it 'creates an NK1 segment' do
      lambda do
        nk1 = HL7::Message::Segment::NK1.new( @base_nk1 )
        nk1.should_not be_nil
        nk1.to_s.should eq @base_nk1
      end.should_not raise_error
    end

    it 'allows access to an NK1 segment' do
      lambda do
        nk1 = HL7::Message::Segment::NK1.new( @base_nk1 )
        nk1.name.should eq 'Mum^Martha^M^^^^L'
        nk1.phone_number.should eq '^PRN^PH^^1^555^5552006'
      end.should_not raise_error
    end
  end
end
