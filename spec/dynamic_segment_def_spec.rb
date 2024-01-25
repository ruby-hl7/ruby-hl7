# encoding: UTF-8
require 'spec_helper'

describe 'dynamic segment definition' do
  context 'general' do
    it 'accepts a block with a parameter' do
      seg = HL7::Message::Segment.new do |s|
        s.e0 = "MSK"
        s.e1 = "1234"
        s.e2 = "5678"
      end

      expect(seg.to_s).to eq "MSK|1234|5678"
    end

    it 'accepts a block without a parameter' do
      seg = HL7::Message::Segment.new do
        e0 "MSK"
        e1 "1234"
        e2 "5678"
      end

      expect(seg.to_s).to eq "MSK|1234|5678"
    end

    it "doesn't pollute the caller namespace" do
      seg = HL7::Message::Segment.new do |s|
        s.e0 = "MSK"
        s.e1 = "1234"
        s.e2 = "5678"
      end

      expect { e3 "TEST" }.to raise_error(NoMethodError)
      expect(seg.to_s).to eq "MSK|1234|5678"
    end
  end
end
