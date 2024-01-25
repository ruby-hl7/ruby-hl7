require 'spec_helper'

describe HL7::Message::Segment do
  describe 'length' do

    it "should return the length of the elements" do
      segment = HL7::Message::Segment.new "MSA|AR|ZZ9380 ERR"
      expect(segment.length).to eq 3
    end
  end

  describe 'enumerable' do
    it 'enumerates over elements' do
      seg = HL7::Message::Segment::Default.new
      segment_count = 0
      seg.each do |s|
        segment_count = segment_count + 1
      end
      expect(segment_count).to eq(seg.length)
    end
  end

  describe 'is_child_segment?' do
    let(:segment){ HL7::Message::Segment.new "MSA|AR|ZZ9380 ERR" }
    it "return false when is not set" do
      expect(segment.is_child_segment?).to be false
    end
  end

  describe 'convert_to_ts' do
    let(:time_now){ DateTime.now }
    let(:formated_time){ time_now.strftime('%Y%m%d%H%M%S') }

    it "should conver to the hl7 time format" do
      expect(HL7::Message::Segment.convert_to_ts(time_now)).to eq formated_time
    end
  end
end
