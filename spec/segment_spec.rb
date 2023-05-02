require 'spec_helper'

describe HL7::Message::Segment do
  describe 'length' do
    it 'returns the length of the elements' do
      segment = described_class.new 'MSA|AR|ZZ9380 ERR'
      expect(segment.length).to eq 3
    end
  end

  describe 'enumerable' do
    it 'enumerates over elements' do
      seg = HL7::Message::Segment::Default.new
      segment_count = 0
      seg.each do |_s|
        segment_count += 1
      end
      expect(segment_count).to eq(seg.length)
    end
  end

  describe 'is_child_segment?' do
    let(:segment) { described_class.new 'MSA|AR|ZZ9380 ERR' }

    it 'return false when is not set' do
      expect(segment.is_child_segment?).to be false
    end
  end

  describe 'convert_to_ts' do
    let(:time_now) { DateTime.now }
    let(:formated_time) { time_now.strftime('%Y%m%d%H%M%S') }

    it 'convers to the hl7 time format' do
      expect(described_class.convert_to_ts(time_now)).to eq formated_time
    end
  end
end
