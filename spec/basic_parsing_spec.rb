# encoding: UTF-8
require 'spec_helper'

describe HL7::Message do
  context 'basic parsing' do
    before :all do
      @simple_msh_txt = open( './test_data/test.hl7' ).readlines.first
      @empty_txt = open( './test_data/empty.hl7' ).readlines.first
      @empty_segments_txt = open( './test_data/empty_segments.hl7' ).readlines.first
      @base_msh = "MSH|^~\\&|LAB1||DESTINATION||19910127105114||ORU^R03|LAB1003929"
      @base_msh_alt_delims = "MSH$@~\\&|LAB1||DESTINATION||19910127105114||ORU^R03|LAB1003929"
    end

    it 'parses simple text' do
      msg = HL7::Message.new
      msg.parse @simple_msh_txt
      msg.to_hl7.should == @simple_msh_txt
    end

    it 'parses delimiters properly' do
      msg = HL7::Message.new( @base_msh )
      msg.element_delim.should == "|"
      msg.item_delim.should == "^"

      msg = HL7::Message.new( @base_msh_alt_delims )
      msg.element_delim.should == "$"
      msg.item_delim.should == "@"
    end

    it 'parses via the constructor' do
      msg = HL7::Message.new( @simple_msh_txt )
      msg.to_hl7.should == @simple_msh_txt
    end

    it 'parses via the class method' do
      msg = HL7::Message.parse( @simple_msh_txt )
      msg.to_hl7.should == @simple_msh_txt
    end

    it 'only parses String and Enumerable data' do
      lambda { msg = HL7::Message.parse :MSHthis_shouldnt_parse_at_all }.should raise_error(HL7::ParseError)
    end

    it 'parses empty strings' do
      lambda { msg = HL7::Message.new @empty_txt }.should_not raise_error
    end

    it 'converts to strings' do
      msg = HL7::Message.new
      msg.parse @simple_msh_txt
      orig = @simple_msh_txt.gsub( /\r/, "\n" )
      msg.to_s.should == orig
    end

    it 'converts to a string and to HL7' do
      msg = HL7::Message.new( @simple_msh_txt )
      msg.to_hl7.should_not == msg.to_s
    end

    it 'allows access to segments by index' do
      msg = HL7::Message.new
      msg.parse @simple_msh_txt
      msg[0].to_s.should == @base_msh
    end

    it 'allows access to segments by name' do
      msg = HL7::Message.new
      msg.parse @simple_msh_txt
      msg["MSH"].to_s.should == @base_msh
    end

    it 'allows access to segments by symbol' do
      msg = HL7::Message.new
      msg.parse @simple_msh_txt
      msg[:MSH].to_s.should == @base_msh
    end

    it 'inserts segments by index' do
      msg = HL7::Message.new
      msg.parse @simple_msh_txt
      inp = HL7::Message::Segment::Default.new
      msg[1] = inp
      msg[1].should == inp

      lambda { msg[2] = Class.new }.should raise_error(HL7::Exception)
    end

    it 'returns nil when accessing a missing segment' do
      msg = HL7::Message.new
      msg.parse @simple_msh_txt
      lambda { msg[:does_not_exist].should be_nil }.should_not raise_error
    end

    it 'inserts segments by name' do
      msg = HL7::Message.new
      msg.parse @simple_msh_txt
      inp = HL7::Message::Segment::NTE.new
      msg["NTE"] = inp
      msg["NTE"].should == inp
      lambda { msg["NTE"] = Class.new }.should raise_error(HL7::Exception)
    end

    it 'inserts segments by symbol' do
      msg = HL7::Message.new
      msg.parse @simple_msh_txt
      inp = HL7::Message::Segment::NTE.new
      msg[:NTE] = inp
      msg[:NTE].should == inp
      lambda { msg[:NTE] = Class.new }.should raise_error(HL7::Exception)
    end

    it 'allows access to segment elements' do
      msg = HL7::Message.new
      msg.parse @simple_msh_txt
      msg[:MSH].sending_app.should == "LAB1"
    end

    it 'allows modification of segment elements' do
      msg = HL7::Message.new
      msg.parse @simple_msh_txt
      msg[:MSH].sending_app = "TEST"
      msg[:MSH].sending_app.should == "TEST"
    end

    it 'raises NoMethodError when accessing a missing element' do
      msg = HL7::Message.new
      msg.parse @simple_msh_txt
      lambda {msg[:MSH].does_not_really_exist_here}.should raise_error(NoMethodError)
    end

    it 'raises NoMethodError when modifying a missing element' do
      msg = HL7::Message.new
      msg.parse @simple_msh_txt
      lambda {msg[:MSH].does_not_really_exist_here="TEST"}.should raise_error(NoMethodError)
    end

    it 'permits elements to be accessed via numeric names' do
      msg = HL7::Message.new( @simple_msh_txt )
      msg[:MSH].e2.should == "LAB1"
      msg[:MSH].e3.should be_empty
    end

    it 'permits elements to be modified via numeric names' do
      msg = HL7::Message.parse( @simple_msh_txt )
      msg[:MSH].e2 = "TESTING1234"
      msg[:MSH].e2.should == "TESTING1234"
    end

    it 'allows appending of segments' do
      msg = HL7::Message.new
      lambda do
        msg << HL7::Message::Segment::MSH.new
        msg << HL7::Message::Segment::NTE.new
      end.should_not raise_error

      lambda { msg << Class.new }.should raise_error(HL7::Exception)
    end

    it 'allows appending of an array of segments' do
      msg = HL7::Message.new
      lambda do
        msg << [HL7::Message::Segment::MSH.new, HL7::Message::Segment::NTE.new]
      end.should_not raise_error

      obx = HL7::Message::Segment::OBX.new
      lambda do
        obx.children << [HL7::Message::Segment::NTE.new, HL7::Message::Segment::NTE.new]
      end.should_not raise_error
    end

    it 'sorts segments' do
      msg = HL7::Message.new
      pv1 = HL7::Message::Segment::PV1.new
      msg << pv1
      msh = HL7::Message::Segment::MSH.new
      msg << msh
      nte = HL7::Message::Segment::NTE.new
      msg << nte
      nte2 = HL7::Message::Segment::NTE.new
      msg << nte
      msh.sending_app = "TEST"

      initial = msg.to_s
      sorted = msg.sort
      final = sorted.to_s
      initial.should_not == final
    end

    it 'automatically assigns a set_id to a new segment' do
      msg = HL7::Message.new
      msh = HL7::Message::Segment::MSH.new
      msg << msh
      ntea = HL7::Message::Segment::NTE.new
      ntea.comment = "first"
      msg << ntea
      nteb = HL7::Message::Segment::NTE.new
      nteb.comment = "second"
      msg << nteb
      ntec = HL7::Message::Segment::NTE.new
      ntec.comment = "third"
      msg << ntec
      ntea.set_id.should == "1"
      nteb.set_id.should == "2"
      ntec.set_id.should == "3"
    end

    it 'parses Enumerable data' do
      test_file = open( './test_data/test.hl7' )
      test_file.should_not be_nil

      msg = HL7::Message.new( test_file )
      msg.to_hl7.should == @simple_msh_txt
    end

    it 'has a to_info method' do
      msg = HL7::Message.new( @simple_msh_txt )
      msg[1].to_info.should_not be_nil
    end

    it 'parses a raw array' do
      inp = "NTE|1|ME TOO"
      nte = HL7::Message::Segment::NTE.new( inp.split( '|' ) )
      nte.to_s.should == inp
    end

    it 'produces MLLP output' do
      msg = HL7::Message.new( @simple_msh_txt )
      expect = "\x0b%s\x1c\r" % msg.to_hl7
      msg.to_mllp.should == expect
    end

    it 'parses MLLP input' do
      raw = "\x0b%s\x1c\r" % @simple_msh_txt
      msg = HL7::Message.parse( raw )
      msg.should_not be_nil
      msg.to_hl7.should == @simple_msh_txt
      msg.to_mllp.should == raw
    end

    it 'can parse its own MLLP output' do
      msg = HL7::Message.parse( @simple_msh_txt )
      msg.should_not be_nil
      lambda do
        post_mllp = HL7::Message.parse( msg.to_mllp )
        post_mllp.should_not be_nil
        msg.to_hl7.should == post_mllp.to_hl7
      end.should_not raise_error
    end

    it 'can access child elements' do
      obr = HL7::Message::Segment::OBR.new
      lambda do
        obr.children.should_not be_nil
        obr.children.length.should be_zero
      end.should_not raise_error
    end

    it 'can add child elements' do
      obr = HL7::Message::Segment::OBR.new
      lambda do
        obr.children.length.should be_zero
        (1..5).each do |x|
          obr.children << HL7::Message::Segment::OBX.new
          obr.children.length.should == x
        end
      end.should_not raise_error
    end

    it 'rejects invalid child segments' do
      obr = HL7::Message::Segment::OBR.new
      lambda { obr.children << Class.new }.should raise_error(HL7::Exception)
    end

    it 'supports grouped, sequenced segments' do
      #multible obr's with multiple obx's
      msg = HL7::Message.parse( @simple_msh_txt )
      orig_output = msg.to_hl7
      orig_obx_cnt = msg[:OBX].length
      (1..10).each do |obr_id|
        obr = HL7::Message::Segment::OBR.new
        msg << obr
        (1..10).each do |obx_id|
          obx = HL7::Message::Segment::OBX.new
          obr.children << obx
        end
      end

      msg[:OBR].should_not be_nil
      msg[:OBR].length.should == 11
      msg[:OBX].should_not be_nil
      msg[:OBX].length.should == 102
      msg[:OBR][4].children[1].set_id.should == "2"
      msg[:OBR][5].children[1].set_id.should == "2"

      final_output = msg.to_hl7
      orig_output.should_not == final_output
    end

    it "returns each segment's index" do
      msg = HL7::Message.parse( @simple_msh_txt )
      msg.index("PID").should == 1
      msg.index(:PID).should == 1
      msg.index("PV1").should == 2
      msg.index(:PV1).should == 2
      msg.index("TACOBELL").should be_nil
      msg.index(nil).should be_nil
      msg.index(1).should be_nil
    end

    it 'validates the PID#admin_sex element' do
      pid = HL7::Message::Segment::PID.new
      lambda { pid.admin_sex = "TEST" }.should raise_error(HL7::InvalidDataError)
      lambda { pid.admin_sex = "F" }.should_not raise_error
    end

    it 'can parse an empty segment' do
      lambda { msg = HL7::Message.new @empty_segments_txt }.should_not raise_error
    end
  end
end
