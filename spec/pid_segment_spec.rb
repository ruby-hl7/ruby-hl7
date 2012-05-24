# encoding: UTF-8
$: << '../lib'
require 'ruby-hl7'

describe HL7::Message::Segment::PID do
  context 'general' do
    before :all do
      @base = "PID|||333||LastName^FirstName^MiddleInitial^SR^NickName||19760228|F||||||||||555. 55|012345678||||||||||201011110924-0700|Y"
    end

    it 'validates the admin_sex element' do
      pid = HL7::Message::Segment::PID.new
      lambda do
        vals = %w[F M O U A N C] + [ nil ]
        vals.each do |x|
          pid.admin_sex = x
        end
        pid.admin_sex = ""
      end.should_not raise_error

      lambda do
        ["TEST", "A", 1, 2].each do |x|
          pid.admin_sex = x
        end
      end.should raise_error(HL7::InvalidDataError)

    end

    it 'supports death fields' do
      pid = HL7::Message::Segment::PID.new @base
      pid.death_date.should == '201011110924-0700'
      pid.death_indicator.should == 'Y'
    end
  end
end
