# frozen_string_literal: true

require "spec_helper"

RSpec.describe StringFormatterHelper, :type => :helper do
  describe "#hl7_batch?" do
    context "when string has a batch identifier" do
      let(:string) { HL7MESSAGES[:realm_batch] }

      it "returns true" do
        expect(hl7_batch?(string)).to be true
      end
    end

    context "when string does not have a batch identifier" do
      let(:string) { HL7MESSAGES[:realm_minimal_message] }

      it "returns false" do
        expect(hl7_batch?(string)).to be false
      end
    end
  end
end
