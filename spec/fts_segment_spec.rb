require 'spec_helper'

describe HL7::Message::Segment::FTS do
  context 'general' do
    before :all do
      base_string = 'FTS||End of File'
      @fts = described_class.new(base_string)
    end

    it 'creates an FTS segment' do
      expect(@fts).not_to be_nil
    end

    it 'allows access to an FTS segment' do
      expect(@fts.file_batch_count).to eq('')
      expect(@fts.file_trailer_comment).to eq('End of File')
    end
  end
end
