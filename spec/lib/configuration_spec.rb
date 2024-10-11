require 'spec_helper'

describe HL7::Configuration do
  describe '.enable_repetitions=' do
    before do
      HL7.configuration.preserve_data_types = preserve_data_types
    end

    context 'when `preserve_data_types` is `false`' do
      let(:preserve_data_types) { false }

      it 'raises an error' do
        expect do
          HL7.configuration.enable_repetitions = true
        end.to raise_error(ArgumentError, /requires.*preserve_data_types/)
      end
    end

    context 'when `preserve_data_types` is `true`' do
      let(:preserve_data_types) { true }

      it 'enables repetitions' do
        HL7.configuration.enable_repetitions = true
        expect(HL7.configuration.enable_repetitions).to be_truthy
      end
    end
  end
end
