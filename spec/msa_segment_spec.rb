# encoding: UTF-8
$: << '../lib'
require 'ruby-hl7'

describe HL7::Message::Segment::MSA do
  context 'general' do
    before :all do
      @base_msa = "MSA|AR|ZZ9380 ERR"
    end

    it 'creates an MSA segment' do
      lambda do
        msa = HL7::Message::Segment::MSA.new( @base_msa )
        msa.should_not be_nil
        msa.to_s.should eq @base_msa
      end.should_not raise_error
    end

    it 'allows access to an MSA segment' do
      lambda do
        msa = HL7::Message::Segment::MSA.new( @base_msa )
        msa.ack_code.should eq "AR"
        msa.control_id.should eq "ZZ9380 ERR"
      end.should_not raise_error
    end
  end
end
