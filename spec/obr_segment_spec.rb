# encoding: UTF-8
require 'spec_helper'

describe HL7::Message::Segment::OBR do
  context 'general' do
    before :all do
      @base = "OBR|2|^USSSA|0000000567^USSSA|37956^CT ABDOMEN^LN|||199405021550|||||||||||||0000763||||NMR|P||||||R/O TUMOR|202300&BAKER&MARK&E|||01&LOCHLEAR&JUDY|||||||||||||||123"
      @obr = HL7::Message::Segment::OBR.new @base
    end

    it 'allows access to an OBR segment' do
      @obr.to_s.should eq @base
      @obr.e1.should eq "2"
      @obr.set_id.should eq "2"
      @obr.placer_order_number.should eq "^USSSA"
      @obr.filler_order_number.should eq "0000000567^USSSA"
      @obr.universal_service_id.should eq "37956^CT ABDOMEN^LN"
    end

    it 'allows modification of an OBR segment' do
      @obr.set_id = 1
      @obr.set_id.should eq "1"
      @obr.placer_order_number = "^DMCRES"
      @obr.placer_order_number.should eq "^DMCRES"
    end

    it 'supports the diagnostic_serv_sect_id method' do
      @obr.should respond_to(:diagnostic_serv_sect_id)
      @obr.diagnostic_serv_sect_id.should eq "NMR"
    end

    it 'supports the result_status method' do
      @obr.should respond_to(:result_status)
      @obr.result_status.should eq "P"
    end

    it 'supports the reason_for_study method' do
      @obr.reason_for_study.should eq "R/O TUMOR"
    end

    it 'supports the parent_universal_service_identifier method' do
      @obr.parent_universal_service_identifier.should eq "123"
    end
  end
end
