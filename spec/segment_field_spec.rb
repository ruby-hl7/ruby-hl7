require 'spec_helper'

class MockSegment < HL7::Message::Segment
  weight 1
  add_field :no_block
  alias_field :no_block_alias, :no_block
  add_field :validating do |value|
    value == 'bad' ? nil : value
  end
  add_field :converting do |value|
    "X#{value}"
  end
end

describe HL7::Message::Segment do
  before :all do
    @base = 'Mock|no_block|validated|converted'
  end

  context 'block on field definitions' do
    it 'is evaluated on access by field name' do
      msg = MockSegment.new(@base)

      expect(msg.to_s).to       eq @base
      expect(msg.no_block).to   eq 'no_block'
      expect(msg.validating).to eq 'validated'
      expect(msg.converting).to eq 'Xconverted'

      msg.no_block = 'NO_BLOCK'
      expect(msg.no_block).to eq 'NO_BLOCK'

      msg.validating = 'good'
      expect(msg.validating).to eq 'good'
      msg.validating = 'bad'
      expect(msg.validating).to eq ''

      msg.converting = 'empty'
      expect(msg.converting).to eq 'XXempty'
    end

    it 'is not evaluated on read access by eXXX alias' do
      msg = MockSegment.new(@base)

      expect(msg.e1).to eq 'no_block'
      expect(msg.e2).to eq 'validated'
      expect(msg.e3).to eq 'converted'
    end

    it 'is not evaluated on write access by eXXX alias' do
      msg = MockSegment.new(@base)

      msg.e1 = 'NO_BLOCK'
      expect(msg.e1).to eq 'NO_BLOCK'

      msg.e2 = 'good'
      expect(msg.e2).to eq 'good'
      msg.e2 = 'bad'
      expect(msg.e2).to eq 'bad'

      msg.e3 = 'empty'
      expect(msg.e3).to eq 'empty'
    end
  end

  describe '#[]' do
    it 'allows index access to the segment' do
      msg = described_class.new(@base)
      expect(msg[0]).to eq 'Mock'
      expect(msg[1]).to eq 'no_block'
      expect(msg[2]).to eq 'validated'
      expect(msg[3]).to eq 'converted'
    end
  end

  describe '#[]=' do
    it 'allows index assignment to the segment' do
      msg = described_class.new(@base)
      msg[0] = 'Kcom'
      expect(msg[0]).to eq 'Kcom'
    end
  end

  describe '#alias_field' do
    context 'with a valid field' do
      it 'uses alias field names' do
        msg = MockSegment.new(@base)
        expect(msg.no_block).to eq 'no_block'
        expect(msg.no_block_alias).to eq 'no_block'
      end
    end

    context 'with an invalid field' do
      class MockInvalidSegment < HL7::Message::Segment
        weight 1
        add_field :no_block
        alias_field :no_block_alias, :invalid_field
        add_field :second
        add_field :third
      end

      it 'throws an error when the field is invalid' do
        msg = MockInvalidSegment.new(@base)
        expect { msg.no_block_alias }.to raise_error(HL7::InvalidDataError)
      end
    end
  end
end
