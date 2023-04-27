require 'spec_helper'

describe HL7::Message::SegmentGenerator do
  describe 'valid_segments_parts?' do
    let(:element) { 'MSH|1|2|3' }
    let(:delimiter) { HL7::Message::Delimiter.new('|', '^', '\r') }
    let(:segment_generator) do
      described_class.new(element, nil, delimiter)
    end

    it 'returns true if @seg_parts is an array of one element or more' do
      expect(segment_generator.valid_segments_parts?).to be true
    end

    context 'when is empty' do
      it 'returns false if empty_segment_is_error is false' do
        segment_generator.seg_parts = nil
        HL7.configuration.empty_segment_is_error = false
        expect(segment_generator.valid_segments_parts?).to be false
      end

      it 'raises an error if empty_segment_is_error is true' do
        HL7.configuration.empty_segment_is_error = true
        segment_generator.seg_parts = nil
        expect do
          segment_generator.valid_segments_parts?
        end.to raise_error HL7::EmptySegmentNotAllowed
      end
    end
  end
end
