# encoding: UTF-8
require 'spec_helper'

describe HL7::Message do
  context 'batch parsing' do
    it 'should have a class method HL7::Message.parse_batch' do
      HL7::Message.should respond_to(:parse_batch)
    end

    it 'should raise an exception when parsing an empty batch' do
      # :empty_batch message contains a valid batch envelope with no
      # contents
      lambda do
        HL7::Message.parse_batch HL7MESSAGES[:empty_batch]
      end.should raise_exception(HL7::ParseError, 'empty_batch_message')
    end

    it 'should raise an exception when parsing a single message as a batch' do
      lambda do
        HL7::Message.parse_batch HL7MESSAGES[:realm_minimal_message]
      end.should raise_exception(HL7::ParseError, 'badly_formed_batch_message')
    end

    it 'should yield multiple messages from a valid batch' do
      count = 0
      HL7::Message.parse_batch(HL7MESSAGES[:realm_batch]) do |m|
        count += 1
      end
      count.should eq 2
    end
  end
end

describe 'String extension' do
  before :all do
    @batch_message = HL7MESSAGES[:realm_batch]
    @plain_message = HL7MESSAGES[:realm_minimal_message]
  end

  it 'should respond_to :hl7_batch?' do
    @batch_message.hl7_batch?.should be true
    @plain_message.should respond_to(:hl7_batch?)
  end

  it 'should return true when passed a batch message' do
    @batch_message.should be_an_hl7_batch
  end

  it 'should return false when passed a plain message' do
    @plain_message.should_not be_an_hl7_batch
  end
end
