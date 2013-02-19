# encoding: UTF-8
require 'spec_helper'

describe HL7::Message::Segment::SPM do
  context 'general' do
    before :all do
      @base_spm = 'SPM|1|23456&EHR&2.16.840.1.113883.19.3.2.3&ISO^9700122&Lab&2.16.840.1.113883.19.3.1.6&ISO||122554006^Capillary blood specimen^SCT^BLDC^Blood capillary^HL70070^20080131^2.5.1||HEPA^Ammonium heparin^HL70371^^^^2.5.1|CAP^Capillary Specimen^HL70488^^^^2.5.1|181395001^Venous structure of digit^SCT^^^^20080731|||P^Patient^HL60369^^^^2.5.1|50^uL&Micro Liter&UCUM&&&&1.6|||||200808151030-0700|200808151100-0700'
    end

    it 'creates an SPM segment' do
      lambda do
        spm = HL7::Message::Segment::SPM.new( @base_spm )
        spm.should_not be_nil
        spm.to_s.should == @base_spm
      end.should_not raise_error
    end

    it 'allows access to an SPM segment' do
      lambda do
        spm = HL7::Message::Segment::SPM.new( @base_spm )
        spm.specimen_type.should == '122554006^Capillary blood specimen^SCT^BLDC^Blood capillary^HL70070^20080131^2.5.1'
        spm.set_id.should == '1'
      end.should_not raise_error
    end
  end
end
