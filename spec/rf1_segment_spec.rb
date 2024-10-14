require "spec_helper"

describe HL7::Message::Segment::RF1 do
  context "general" do
    before :all do
      @base = "RF1|P^Pending^HL70283|R^Routine^HL70280|GRF^General referral^HL70281|AM^Assume management^HL70282||8094|20060705||20060705||42"
    end

    it "allows access to an RF1 segment" do
      rf1 = HL7::Message::Segment::RF1.new @base
      expect(rf1.referral_status).to eq "P^Pending^HL70283"
      expect(rf1.referral_priority).to eq "R^Routine^HL70280"
      expect(rf1.referral_type).to eq "GRF^General referral^HL70281"
      expect(rf1.referral_disposition).to eq "AM^Assume management^HL70282"
      expect(rf1.originating_referral_identifier).to eq "8094"
      expect(rf1.effective_date).to eq "20060705"
      expect(rf1.process_date).to eq "20060705"
      expect(rf1.external_referral_identifier).to eq "42"
    end

    it "allows creation of an RF1 segment" do
      rf1 = HL7::Message::Segment::RF1.new
      rf1.expiration_date = Date.new(2058, 12, 1)
      expect(rf1.expiration_date).to eq "20581201"
    end
  end
end
