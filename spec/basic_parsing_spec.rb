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
      expect(msg.to_hl7).to eq @simple_msh_txt
    end

    it 'parses delimiters properly' do
      msg = HL7::Message.new( @base_msh )
      expect(msg.element_delim).to eq "|"
      expect(msg.item_delim).to eq "^"

      msg = HL7::Message.new( @base_msh_alt_delims )
      expect(msg.element_delim).to eq "$"
      expect(msg.item_delim).to eq "@"
    end

    it 'parses via the constructor' do
      msg = HL7::Message.new( @simple_msh_txt )
      expect(msg.to_hl7).to eq @simple_msh_txt
    end

    it 'parses via the class method' do
      msg = HL7::Message.parse( @simple_msh_txt )
      expect(msg.to_hl7).to eq @simple_msh_txt
    end

    it 'only parses String and Enumerable data' do
      expect { HL7::Message.parse :MSHthis_shouldnt_parse_at_all }.to raise_error(HL7::ParseError)
    end

    it 'parses empty strings' do
      expect { HL7::Message.new @empty_txt }.not_to raise_error
    end

    it 'converts to strings' do
      msg = HL7::Message.new
      msg.parse @simple_msh_txt
      orig = @simple_msh_txt.gsub( /\r/, "\n" )
      expect(msg.to_s).to eq orig
    end

    it 'converts to a string and to HL7' do
      msg = HL7::Message.new( @simple_msh_txt )
      expect(msg.to_hl7).not_to eq(msg.to_s)
    end

    it 'allows access to segments by index' do
      msg = HL7::Message.new
      msg.parse @simple_msh_txt
      expect(msg[0].to_s).to eq @base_msh
    end

    it 'allows access to segments by name' do
      msg = HL7::Message.new
      msg.parse @simple_msh_txt
      expect(msg["MSH"].to_s).to eq @base_msh
    end

    it 'allows access to segments by symbol' do
      msg = HL7::Message.new
      msg.parse @simple_msh_txt
      expect(msg[:MSH].to_s).to eq @base_msh
    end

    it 'inserts segments by index' do
      msg = HL7::Message.new
      msg.parse @simple_msh_txt
      inp = HL7::Message::Segment::Default.new
      msg[1] = inp
      expect(msg[1]).to eq inp

      expect { msg[2] = Class.new }.to raise_error(HL7::Exception)
    end

    it 'returns nil when accessing a missing segment' do
      msg = HL7::Message.new
      msg.parse @simple_msh_txt
      expect { expect(msg[:does_not_exist]).to be_nil }.not_to raise_error
    end

    it 'inserts segments by name' do
      msg = HL7::Message.new
      msg.parse @simple_msh_txt
      inp = HL7::Message::Segment::NTE.new
      msg["NTE"] = inp
      expect(msg["NTE"]).to eq inp
      expect { msg["NTE"] = Class.new }.to raise_error(HL7::Exception)
    end

    it 'inserts segments by symbol' do
      msg = HL7::Message.new
      msg.parse @simple_msh_txt
      inp = HL7::Message::Segment::NTE.new
      msg[:NTE] = inp
      expect(msg[:NTE]).to eq inp
      expect { msg[:NTE] = Class.new }.to raise_error(HL7::Exception)
    end

    it 'allows access to segment elements' do
      msg = HL7::Message.new
      msg.parse @simple_msh_txt
      expect(msg[:MSH].sending_app).to eq "LAB1"
    end

    it 'allows modification of segment elements' do
      msg = HL7::Message.new
      msg.parse @simple_msh_txt
      msg[:MSH].sending_app = "TEST"
      expect(msg[:MSH].sending_app).to eq "TEST"
    end

    it 'raises NoMethodError when accessing a missing element' do
      msg = HL7::Message.new
      msg.parse @simple_msh_txt
      expect {msg[:MSH].does_not_really_exist_here}.to raise_error(NoMethodError)
    end

    it 'raises NoMethodError when modifying a missing element' do
      msg = HL7::Message.new
      msg.parse @simple_msh_txt
      expect {msg[:MSH].does_not_really_exist_here="TEST"}.to raise_error(NoMethodError)
    end

    it 'permits elements to be accessed via numeric names' do
      msg = HL7::Message.new( @simple_msh_txt )
      expect(msg[:MSH].e2).to eq "LAB1"
      expect(msg[:MSH].e3).to be_empty
    end

    it 'permits elements to be modified via numeric names' do
      msg = HL7::Message.parse( @simple_msh_txt )
      msg[:MSH].e2 = "TESTING1234"
      expect(msg[:MSH].e2).to eq "TESTING1234"
    end

    it 'allows appending of segments' do
      msg = HL7::Message.new
      expect do
        msg << HL7::Message::Segment::MSH.new
        msg << HL7::Message::Segment::NTE.new
      end.not_to raise_error

      expect { msg << Class.new }.to raise_error(HL7::Exception)
    end

    it 'allows appending of an array of segments' do
      msg = HL7::Message.new
      expect do
        msg << [HL7::Message::Segment::MSH.new, HL7::Message::Segment::NTE.new]
      end.not_to raise_error

      obx = HL7::Message::Segment::OBX.new
      expect do
        obx.children << [HL7::Message::Segment::NTE.new, HL7::Message::Segment::NTE.new]
      end.not_to raise_error
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
      msg << nte2
      msh.sending_app = "TEST"

      initial = msg.to_s
      sorted = msg.sort
      final = sorted.to_s
      expect(initial).not_to eq(final)
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
      expect(ntea.set_id).to eq "1"
      expect(nteb.set_id).to eq "2"
      expect(ntec.set_id).to eq "3"
    end

    it 'parses Enumerable data' do
      test_file = open( './test_data/test.hl7' )
      expect(test_file).not_to be_nil

      msg = HL7::Message.new( test_file )
      expect(msg.to_hl7).to eq @simple_msh_txt
    end

    it 'has a to_info method' do
      msg = HL7::Message.new( @simple_msh_txt )
      expect(msg[1].to_info).not_to be_nil
    end

    it 'parses a raw array' do
      inp = "NTE|1|ME TOO"
      nte = HL7::Message::Segment::NTE.new( inp.split( '|' ) )
      expect(nte.to_s).to eq inp
    end

    it 'produces MLLP output' do
      msg = HL7::Message.new( @simple_msh_txt )
      expect = "\x0b%s\x1c\r" % msg.to_hl7
      expect(msg.to_mllp).to eq expect
    end

    it 'parses MLLP input' do
      raw = "\x0b%s\x1c\r" % @simple_msh_txt
      msg = HL7::Message.parse( raw )
      expect(msg).not_to be_nil
      expect(msg.to_hl7).to eq @simple_msh_txt
      expect(msg.to_mllp).to eq raw
    end

    it 'can parse its own MLLP output' do
      msg = HL7::Message.parse( @simple_msh_txt )
      expect(msg).not_to be_nil
      expect do
        post_mllp = HL7::Message.parse( msg.to_mllp )
        expect(post_mllp).not_to be_nil
        expect(msg.to_hl7).to eq post_mllp.to_hl7
      end.not_to raise_error
    end

    it 'can access child elements' do
      obr = HL7::Message::Segment::OBR.new
      expect do
        expect(obr.children).not_to be_nil
        expect(obr.children.length).to be_zero
      end.not_to raise_error
    end

    it 'can add child elements' do
      obr = HL7::Message::Segment::OBR.new
      expect do
        expect(obr.children.length).to be_zero
        (1..5).each do |x|
          obr.children << HL7::Message::Segment::OBX.new
          expect(obr.children.length).to eq x
        end
      end.not_to raise_error
    end

    it 'rejects invalid child segments' do
      obr = HL7::Message::Segment::OBR.new
      expect { obr.children << Class.new }.to raise_error(HL7::Exception)
    end

    it 'supports grouped, sequenced segments' do
      #multible obr's with multiple obx's
      msg = HL7::Message.parse( @simple_msh_txt )
      orig_output = msg.to_hl7
      (1..10).each do |obr_id|
        obr = HL7::Message::Segment::OBR.new
        msg << obr
        (1..10).each do |obx_id|
          obx = HL7::Message::Segment::OBX.new
          obr.children << obx
        end
      end

      expect(msg[:OBR]).not_to be_nil
      expect(msg[:OBR].length).to eq 11
      expect(msg[:OBX]).not_to be_nil
      expect(msg[:OBX].length).to eq 102
      expect(msg[:OBR][4].children[1].set_id).to eq "2"
      expect(msg[:OBR][5].children[1].set_id).to eq "2"

      final_output = msg.to_hl7
      expect(orig_output).not_to eq(final_output)
    end

    it "returns each segment's index" do
      msg = HL7::Message.parse( @simple_msh_txt )
      expect(msg.index("PID")).to eq 1
      expect(msg.index(:PID)).to eq 1
      expect(msg.index("PV1")).to eq 2
      expect(msg.index(:PV1)).to eq 2
      expect(msg.index("TACOBELL")).to be_nil
      expect(msg.index(nil)).to be_nil
      expect(msg.index(1)).to be_nil
    end

    it 'validates the PID#admin_sex element' do
      pid = HL7::Message::Segment::PID.new
      expect { pid.admin_sex = "TEST" }.to raise_error(HL7::InvalidDataError)
      expect { pid.admin_sex = "F" }.not_to raise_error
    end

    it 'can parse an empty segment' do
      expect { HL7::Message.new @empty_segments_txt }.not_to raise_error
    end
  end
end
