# frozen_string_literal: true

require "spec_helper"

describe HL7::Message do
  context "batch parsing" do
    it "has a class method HL7::Message.parse_batch" do
      expect(HL7::Message).to respond_to(:parse_batch)
    end

    it "raises an exception when parsing an empty batch" do
      # :empty_batch message contains a valid batch envelope with no
      # contents
      expect do
        HL7::Message.parse_batch HL7MESSAGES[:empty_batch]
      end.to raise_exception(HL7::ParseError, "empty_batch_message")
    end

    it "raises an exception when parsing a single message as a batch" do
      expect do
        HL7::Message.parse_batch HL7MESSAGES[:realm_minimal_message]
      end.to raise_exception(HL7::ParseError, "badly_formed_batch_message")
    end

    it "yields multiple messages from a valid batch" do
      count = 0
      HL7::Message.parse_batch(HL7MESSAGES[:realm_batch]) do |_m|
        count += 1
      end
      expect(count).to eq 2
    end
  end
end
