# encoding: UTF-8
require 'spec_helper'
require 'time'

describe HL7::Message do
  context 'speed parsing' do
    before :all do
      @msg = open( "./test_data/lotsunknowns.hl7" ).readlines
    end

    it 'parses large, unknown segments rapidly' do
      start = Time.now
      doc = HL7::Message.new @msg
      expect(doc).not_to be_nil
      ends = Time.now
      expect(ends-start).to be < 1
    end
  end
end
