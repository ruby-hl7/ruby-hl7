# encoding: UTF-8
require 'spec_helper'

describe HL7::Message do
  context 'child segments' do
    before :all do
      @base = open( './test_data/obxobr.hl7' ).readlines
    end

    it 'allows access to child segments' do
      msg = HL7::Message.new @base
      msg.should_not be_nil
      msg[:OBR].should_not be_nil
      msg[:OBR].length.should eq 3
      msg[:OBR][0].children.should_not be_nil
      msg[:OBR][0].children.length.should eq 6
      msg[:OBR][1].children.should_not be_nil
      msg[:OBR][1].children.length.should eq 3
      msg[:OBR][2].children.should_not be_nil
      msg[:OBR][2].children.length.should eq 1
      msg[:OBX][0].children.should_not be_nil
      msg[:OBX][0].children.length.should eq 1

      msg[:OBR][0].children.each do |x|
        x.should_not be_nil
      end
      msg[:OBR][1].children.each do |x|
        x.should_not be_nil
      end
      msg[:OBR][2].children.each do |x|
        x.should_not be_nil
      end
    end

    it 'allows adding child segments' do
      msg = HL7::Message.new @base
      msg.should_not be_nil
      msg[:OBR].should_not be_nil
      ob = HL7::Message::Segment::OBR.new
      ob.should_not be_nil

      msg << ob
      ob.children.should_not be_nil
      ob.segment_parent.should_not be_nil
      ob.segment_parent.should eq msg
      orig_cnt = msg.length

      (1..4).each do |x|
        m = HL7::Message::Segment::OBX.new
        m.observation_value = "taco"
        m.should_not be_nil
        /taco/.match(m.to_s).should_not be_nil
        ob.children << m
        ob.children.length.should eq x
        m.segment_parent.should_not be_nil
        m.segment_parent.should eq ob
      end

      @base.should_not eq msg.to_hl7
      msg.length.should_not eq orig_cnt
      text_ver = msg.to_hl7
      /taco/.match(text_ver).should_not be_nil
    end
  end
end

