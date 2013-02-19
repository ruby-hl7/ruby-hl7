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
      msg[:OBR].length.should == 3
      msg[:OBR].first.children.should_not be_nil
      msg[:OBR].first.children.length.should == 5

      msg[:OBR].first.children.each do |x|
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
      ob.segment_parent.should == msg
      orig_cnt = msg.length

      (1..4).each do |x|
        m = HL7::Message::Segment::OBX.new
        m.observation_value = "taco"
        m.should_not be_nil
        /taco/.match(m.to_s).should_not be_nil
        ob.children << m
        ob.children.length.should == x
        m.segment_parent.should_not be_nil
        m.segment_parent.should == ob
      end

      @base.should_not == msg.to_hl7
      msg.length.should_not == orig_cnt
      text_ver = msg.to_hl7
      /taco/.match(text_ver).should_not be_nil
    end
  end
end

