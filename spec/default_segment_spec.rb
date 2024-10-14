require "spec_helper"

describe HL7::Message::Segment::Default do
  context "general" do
    before :all do
      @base_msa = "MSA|AR|ZZ9380 ERR"
    end

    it "stores an existing segment" do
      seg = HL7::Message::Segment::Default.new(@base_msa)
      expect(seg.to_s).to eq @base_msa
    end

    it "converts to a string" do
      seg = HL7::Message::Segment::Default.new(@base_msa)
      expect(seg.to_s).to eq @base_msa
      expect(seg.to_hl7).to eq seg.to_s
    end

    it "creates a raw segment" do
      seg = HL7::Message::Segment::Default.new
      seg.e0 = "NK1"
      seg.e1 = "INFO"
      seg.e2 = "MORE INFO"
      seg.e5 = "LAST INFO"
      expect(seg.to_s).to eq "NK1|INFO|MORE INFO|||LAST INFO"
    end
  end
end
