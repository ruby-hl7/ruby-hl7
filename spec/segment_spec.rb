# frozen_string_literal: true

require "spec_helper"

describe HL7::Message::Segment do
  describe "length" do
    it "returns the length of the elements" do
      segment = HL7::Message::Segment.new "MSA|AR|ZZ9380 ERR"
      expect(segment.length).to eq 3
    end
  end

  describe "enumerable" do
    it "enumerates over elements" do
      seg = HL7::Message::Segment::Default.new
      segment_count = 0
      seg.each do |_s|
        segment_count += 1
      end
      expect(segment_count).to eq(seg.length)
    end
  end

  describe "is_child_segment?" do
    let(:segment) { HL7::Message::Segment.new "MSA|AR|ZZ9380 ERR" }

    it "return false when is not set" do
      expect(segment.is_child_segment?).to be false
    end
  end

  describe "#children_list" do
    context "when segment class has children" do
      let(:message) { HL7::Message.new(open("./test_data/obxobr.hl7").readlines) }

      it "returns the children list" do
        expect(message[:OBR].first.children_list).to be_a(Array)
        expect(message[:OBR].first.children_list.map(&:class)).to contain_exactly(HL7::Message::Segment::NTE, HL7::Message::Segment::OBX, HL7::Message::Segment::OBX, HL7::Message::Segment::OBX, HL7::Message::Segment::OBX, HL7::Message::Segment::OBX)
      end
    end

    context "when segment class does not have children" do
      let(:segment) { HL7::Message::Segment::TXA.new "TXA|1|AR|AP|20220611113300|1^Name|20220611|2022061110||1^Creator|" }

      it "returns an empty array" do
        expect(segment.children_list).to eq []
      end
    end
  end

  describe "convert_to_ts" do
    let(:time_now) { DateTime.now }
    let(:formated_time) { time_now.strftime("%Y%m%d%H%M%S") }

    it "convers to the hl7 time format" do
      expect(HL7::Message::Segment.convert_to_ts(time_now)).to eq formated_time
    end
  end
end
