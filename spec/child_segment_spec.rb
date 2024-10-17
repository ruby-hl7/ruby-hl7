# frozen_string_literal: true

require "spec_helper"

describe HL7::Message do
  context "child segments" do
    before :all do
      @base = open("./test_data/obxobr.hl7").readlines
    end

    it "allows access to child segments" do
      msg = HL7::Message.new @base
      expect(msg).not_to be_nil
      expect(msg[:OBR]).not_to be_nil
      expect(msg[:OBR].length).to eq 3
      expect(msg[:OBR][0].children).not_to be_nil
      expect(msg[:OBR][0].children.length).to eq 6
      expect(msg[:OBR][1].children).not_to be_nil
      expect(msg[:OBR][1].children.length).to eq 3
      expect(msg[:OBR][2].children).not_to be_nil
      expect(msg[:OBR][2].children.length).to eq 1
      expect(msg[:OBX][0].children).not_to be_nil
      expect(msg[:OBX][0].children.length).to eq 1

      msg[:OBR][0].children.each do |x|
        expect(x).not_to be_nil
      end
      msg[:OBR][1].children.each do |x|
        expect(x).not_to be_nil
      end
      msg[:OBR][2].children.each do |x|
        expect(x).not_to be_nil
      end
    end

    it "allows adding child segments" do
      msg = HL7::Message.new @base
      expect(msg).not_to be_nil
      expect(msg[:OBR]).not_to be_nil
      ob = HL7::Message::Segment::OBR.new
      expect(ob).not_to be_nil

      msg << ob
      expect(ob.children).not_to be_nil
      expect(ob.segment_parent).not_to be_nil
      expect(ob.segment_parent).to eq msg
      orig_cnt = msg.length

      (1..4).each do |x|
        m = HL7::Message::Segment::OBX.new
        m.observation_value = "taco"
        expect(m).not_to be_nil
        expect(/taco/.match(m.to_s)).not_to be_nil
        ob.children << m
        expect(ob.children.length).to eq x
        expect(m.segment_parent).not_to be_nil
        expect(m.segment_parent).to eq ob
      end

      expect(@base).not_to eq msg.to_hl7
      expect(msg.length).not_to eq orig_cnt
      text_ver = msg.to_hl7
      expect(/taco/.match(text_ver)).not_to be_nil
    end
  end
end
