require "spec_helper"

describe Date do
  subject { Date.parse("2013-12-02").to_hl7 }

  it "responds to the HL7 timestamp" do
    expect(subject).to eq "20131202"
  end
end

describe "to_hl7 for time related classes" do
  let(:formated_time) { time_now.strftime("%Y%m%d%H%M%S") }
  let(:fraction_3) { "." + format("%06d", time_now.to_time.usec)[0, 3] }
  let(:fraction_9) { "." + format("%06d", time_now.to_time.usec) + ("0" * 3) }

  shared_examples "a time to_hl7" do
    context "without fraction" do
      it { expect(time_now.to_time.to_hl7).to eq formated_time }
    end

    context "with_fraction" do
      it { expect(time_now.to_time.to_hl7(3)).to eq formated_time + fraction_3 }

      it { expect(time_now.to_time.to_hl7(9)).to eq formated_time + fraction_9 }
    end
  end

  describe Time do
    let(:time_now) { Time.now }

    it_behaves_like "a time to_hl7"
  end

  describe DateTime do
    let(:time_now) { DateTime.now }

    it_behaves_like "a time to_hl7"
  end
end
