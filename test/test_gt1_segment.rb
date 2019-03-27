# encoding: UTF-8
$: << '../lib'
require 'test/unit'
require 'ruby-hl7'

class GT1Segment < Test::Unit::TestCase
  def setup
    @base = "GT1|||Jane^Doe||123 Guarantor Avenue^^Tucson^AZ^85701|5208675309|5208675310|19010101|F|1"
  end
  
  def test_initial_read
    gt1 = HL7::Message::Segment::GT1.new @base
    assert_equal( "", gt1.set_id )
    assert_equal( "Jane^Doe", gt1.guarantor_name )
    assert_equal( "123 Guarantor Avenue^^Tucson^AZ^85701", gt1.guarantor_address )
    assert_equal( "5208675309", gt1.guarantor_phone )
    assert_equal( "5208675310", gt1.guarantor_work_phone )
    assert_equal( "19010101", gt1.guarantor_dob )
    assert_equal( "F", gt1.guarantor_sex )
    assert_equal( "1", gt1.guarantor_type )
  end
  
  def test_creation
    gt1 = HL7::Message::Segment::GT1.new
    gt1.guarantor_name = "John^Doe"
    gt1.guarantor_address = "The White House^1600Pennsylvania Avenue NW^Washington^DC^20500"
    gt1.guarantor_phone = "2024561111"
    gt1.guarantor_work_phone = "2024561414"
    gt1.guarantor_dob = "17921013"
    gt1.guarantor_sex = "M"
    gt1.guarantor_type = "1"
  end
end