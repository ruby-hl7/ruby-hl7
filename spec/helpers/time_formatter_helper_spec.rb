# frozen_string_literal: true

require "spec_helper"

RSpec.describe TimeFormatterHelper, :type => :helper do
  describe "#hl7_formatted_timestamp" do
    subject(:formatted_date) { hl7_formatted_timestamp(value, fraction_digits) }

    let(:fraction_digits) { 0 }

    context "when value is not a Time nor a DateTime" do
      let(:value) { Date.today }

      it "raises a ValueTypeNotSupportedError" do
        expect { formatted_date }.to raise_error(TimeFormatterHelper::ValueTypeNotSupportedError)
      end
    end

    context "when value is a Time" do
      let(:value) { Time.now }

      context "when fraction_digits is 0 (default value)" do
        it "returns the expected formatted string" do
          expect(formatted_date).to eq(value.strftime("%Y%m%d%H%M%S"))
        end
      end

      context "when fraction_digits is given" do
        let(:fraction_digits) { 9 }
        let(:fraction9) { ".#{format("%06d", value.to_time.usec)}#{"0" * 3}" }

        it "returns the expected formatted string" do
          expect(formatted_date).to eq(value.strftime("%Y%m%d%H%M%S") + fraction9)
        end
      end
    end

    context "when value is a DateTime" do
      let(:value) { DateTime.now }

      context "when fraction_digits is 0 (default value)" do
        it "returns the expected formatted string" do
          expect(formatted_date).to eq(value.strftime("%Y%m%d%H%M%S"))
        end
      end

      context "when fraction_digits is given" do
        let(:fraction_digits) { 3 }
        let(:fraction3) { ".#{format("%06d", value.to_time.usec)[0, 3]}" }

        it "returns the expected formatted string" do
          expect(formatted_date).to eq(value.strftime("%Y%m%d%H%M%S") + fraction3)
        end
      end
    end
  end

  describe "#hl7_formatted_date" do
    subject(:formatted_date) { hl7_formatted_date(value) }

    context "when value is not a Date" do
      let(:value) { Time.new }

      it "raises a ValueTypeNotSupportedError" do
        expect { formatted_date }.to raise_error(TimeFormatterHelper::ValueTypeNotSupportedError)
      end
    end

    context "when value is a Date" do
      let(:value) { Date.today }

      it "returns the expected formatted string" do
        expect(formatted_date).to eq(value.strftime("%Y%m%d"))
      end
    end
  end

  describe "#parsed_hl7_date" do
    context "when value is not a String" do
      let(:value) { Time.new }

      it "raises a ValueTypeNotSupportedError" do
        expect { parsed_hl7_date(value) }.to raise_error(TimeFormatterHelper::ValueTypeNotSupportedError)
      end
    end

    context "when value is a String" do
      let(:value) { Date.today }

      it "returns the expected Date instance" do
        expect(parsed_hl7_date(hl7_formatted_date(value))).to eq(value)
      end
    end
  end

  describe "#parsed_hl7_timestamp" do
    context "when value is not a String" do
      let(:value) { Time.new }

      it "raises a ValueTypeNotSupportedError" do
        expect { parsed_hl7_timestamp(value) }.to raise_error(TimeFormatterHelper::ValueTypeNotSupportedError)
      end
    end

    context "when value is a String" do
      let(:value) { Time.new(2023, 10, 5, 12, 30, 45) }

      it "returns the expected Time instance" do
        expect(parsed_hl7_timestamp(hl7_formatted_timestamp(value))).to eq(value)
      end
    end
  end
end
