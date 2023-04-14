# encoding: UTF-8
require 'spec_helper'

describe HL7::Message::Segment::FT1 do
  context 'general' do
    let(:base_ft1) do
      'FT1|1|||20180705|20180705|||Description||1||||||123456^The Location|||R45.82^Worries~H18.892^Other specified disorders of cornea|1043312457^Provider^Testing^^^^|1043312457^Provider^Testing^^^^||||99392^HEART FAILURE COMPOSITE|'
    end
    subject(:ft1) { HL7::Message::Segment::FT1.new( base_ft1 ) }

    it 'creates an FT1 segment' do
      expect do
        expect(ft1).not_to be_nil
        expect(ft1.to_s).to eq base_ft1
      end.not_to raise_error
    end

    it 'allows access to an FT1 segment' do
      expect do
        expect(ft1.set_id).to eq '1'
        expect(ft1.date_of_service).to eq '20180705'
        expect(ft1.transaction_posting_date).to eq '20180705'
        expect(ft1.transaction_description).to eq 'Description'
        expect(ft1.transaction_quantity).to eq '1'
        expect(ft1.assigned_patient_location).to eq '123456^The Location'
        expect(ft1.performed_by_provider).to eq '1043312457^Provider^Testing^^^^'
        expect(ft1.ordering_provider).to eq '1043312457^Provider^Testing^^^^'
        expect(ft1.procedure_code).to eq '99392^HEART FAILURE COMPOSITE'

      end.not_to raise_error
    end

    context 'when `enable_repetitions` is enabled' do
      before do
        HL7.configuration.preserve_data_types = true
        HL7.configuration.enable_repetitions = true
      end

      it 'returns an Array for `diagnosis_code`' do
        expect(ft1.diagnosis_code).to eq(['R45.82^Worries', 'H18.892^Other specified disorders of cornea'])
      end
    end

    context 'when `enable_repetitions` is disabled' do
      before do
        HL7.configuration.enable_repetitions = false
      end

      it 'returns a String for `diagnosis_code`' do
        expect(ft1.diagnosis_code).to eq('R45.82^Worries~H18.892^Other specified disorders of cornea')
      end
    end
  end
end
