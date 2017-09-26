# encoding: UTF-8
require 'spec_helper'

describe HL7::Message::Segment::RF1 do
  context 'general' do
    before :all do
      @base = 'RF1|P^Pending^HL70283|R^Routine^HL70280|GRF^General referral^HL70281|AM^Assume management^HL70282||8094|20060705||20060705||42'

    end

    it 'allows access to an RF1 segment' do
      rf1 = HL7::Message::Segment::RF1.new @base
      rf1.referral_status.should eq 'P^Pending^HL70283'
      rf1.referral_priority.should eq 'R^Routine^HL70280'
      rf1.referral_type.should eq 'GRF^General referral^HL70281'
      rf1.referral_disposition.should eq 'AM^Assume management^HL70282'
      rf1.originating_referral_identifier.should eq '8094'
      rf1.effective_date.should eq '20060705'
      rf1.process_date.should eq '20060705'
      rf1.external_referral_identifier.should eq '42'
    end

    it 'allows creation of an RF1 segment' do
      rf1 = HL7::Message::Segment::RF1.new
      rf1.expiration_date=Date.new(2058, 12, 1)
      rf1.expiration_date.should eq '20581201'
    end
  end
end
