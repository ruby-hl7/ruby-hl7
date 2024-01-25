# encoding: UTF-8
require 'spec_helper'

describe HL7::Message::Segment::AIP do
  context 'general' do
    before :all do
      @base_aip = 'AIP|1|U|JSB^ISON^Kathy^S|D^Doctor||20020108150000|||10|m^Minutes'
    end

    it 'creates an AIP segment' do
      expect do
        aip = HL7::Message::Segment::AIP.new( @base_aip )
        expect(aip).not_to be_nil
        expect(aip.to_s).to eq @base_aip
      end.not_to raise_error
    end

    it 'allows access to an AIP segment' do
      expect do
        aip = HL7::Message::Segment::AIP.new( @base_aip )
        expect(aip.set_id).to eq '1'
        expect(aip.segment_action_code).to eq 'U'
        expect(aip.personnel_resource_id).to eq 'JSB^ISON^Kathy^S'
        expect(aip.resource_role).to eq 'D^Doctor'
        expect(aip.start_date_time).to eq '20020108150000'
        expect(aip.duration).to eq '10'
        expect(aip.duration_units).to eq 'm^Minutes'
      end.not_to raise_error
    end
  end
end
