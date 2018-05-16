# encoding: UTF-8
require 'spec_helper'

describe HL7::Message do
  context 'add a new segment' do
    before(:all) do
      HL7.configure do |config|
        config.segments.add(:ZXX) do
          weight 1000
          add_field :id
          add_field :ownership
          add_field :value
        end
      end

      @base_msh = "MSH|^~\\&|LAB1||DESTINATION||19910127105114||ORU^R03|LAB1003929"
      @base_zxx = "ZXX|custom_field_1|NOT_ME|custom_value_1"
      @message = "#{@base_msh}\r#{@base_zxx}"
    end

    after(:all) do
      HL7::Message::Segment.send(:remove_const, :ZXX)
    end

    it 'parses all lines' do
      msg = HL7::Message.new
      msg.parse(@message)
      msg.to_hl7.should(eq(@message))
    end

    it 'allows access to new segment elements' do
      msg = HL7::Message.new
      msg.parse(@message)

      msg[:ZXX].id.should(eq('custom_field_1'))
      msg[:ZXX].ownership.should(eq('NOT_ME'))
      msg[:ZXX].value.should(eq('custom_value_1'))
    end

    it 'allows modification of segment elements' do
      msg = HL7::Message.new
      msg.parse(@message)

      msg[:ZXX].ownership = 'YOU'
      msg[:ZXX].ownership.should(eq('YOU'))
    end
  end

  context 'override an existing segment' do
    before(:all) do
      HL7.configure do |config|
        config.segments.update(:PID) do
          add_field :admin_sex, idx: 8
          add_field :awesome_field
        end
      end
    end

    after(:all) do
      HL7::Message::Segment.send(:remove_const, :PID)
      require_relative '../lib/segments/pid'
    end

    it 'allows to bypass the validation on admin_sex by re-defining the field' do
      pid = HL7::Message::Segment::PID.new
      lambda { pid.admin_sex = 'Male' }.should_not(raise_error)
      pid.admin_sex.should(eq('Male'))
    end

    it 'allows to add a field to an existing segment' do
      pid = HL7::Message::Segment::PID.new
      lambda { pid.awesome_field = 'You are a-ma-zing.' }.should_not(raise_error)
      pid.awesome_field.should(eq('You are a-ma-zing.'))
    end
  end
end
