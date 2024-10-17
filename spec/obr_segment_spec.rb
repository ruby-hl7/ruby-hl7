# frozen_string_literal: true

require "spec_helper"

describe HL7::Message::Segment::OBR do
  context "general" do
    before :all do
      @base = "OBR|2|^USSSA|0000000567^USSSA|37956^CT ABDOMEN^LN|||199405021550|||||||||||||0000763||||NMR|P||||||R/O TUMOR|202300&BAKER&MARK&E|||01&LOCHLEAR&JUDY|||||||||||||||123"
      @obr = HL7::Message::Segment::OBR.new @base
    end

    it "allows access to an OBR segment" do
      expect(@obr.to_s).to eq @base
      expect(@obr.e1).to eq "2"
      expect(@obr.set_id).to eq "2"
      expect(@obr.placer_order_number).to eq "^USSSA"
      expect(@obr.filler_order_number).to eq "0000000567^USSSA"
      expect(@obr.universal_service_id).to eq "37956^CT ABDOMEN^LN"
    end

    it "allows modification of an OBR segment" do
      @obr.set_id = 1
      expect(@obr.set_id).to eq "1"
      @obr.placer_order_number = "^DMCRES"
      expect(@obr.placer_order_number).to eq "^DMCRES"
    end

    it "supports the diagnostic_serv_sect_id method" do
      expect(@obr).to respond_to(:diagnostic_serv_sect_id)
      expect(@obr.diagnostic_serv_sect_id).to eq "NMR"
    end

    it "supports the result_status method" do
      expect(@obr).to respond_to(:result_status)
      expect(@obr.result_status).to eq "P"
    end

    it "supports the reason_for_study method" do
      expect(@obr.reason_for_study).to eq "R/O TUMOR"
    end

    it "supports the parent_universal_service_identifier method" do
      expect(@obr.parent_universal_service_identifier).to eq "123"
    end
  end
end
