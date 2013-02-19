require 'spec_helper'

class SegmentNoChildren< HL7::Message::Segment
end

class SegmentWithChildren < HL7::Message::Segment
  has_children [:NTE,:ORC,:SPM]
end

describe HL7::Message::SegmentListStorage do
  describe "self#add_child_type" do
    it "should allow to add a new segment type as child" do
      SegmentWithChildren.add_child_type :OBR
      segment = SegmentWithChildren.new
      segment.accepts?(:OBR).should be_true
      segment.child_types.should include :OBR
    end
  end

  describe "Adding children has_children and add_child_type" do
    subject do
      segment_instance = segment_class.new
      methods = [:accepts?, :child_types, :children].each do |method|
        segment_instance.respond_to?(method).should be_true
      end
    end

    context "when child_types is not present" do
      let(:segment_class){ SegmentNoChildren }

      it "by adding add_child_type should respond to the children methods" do
        segment_instance = segment_class.new
        segment_instance.respond_to?(:children).should be_false
        segment_class.add_child_type(:OBR)
        subject
      end
    end

    context "when child_types is present" do
      let(:segment_class){ SegmentWithChildren }

      it "should respond to the children methods" do
        subject
      end
    end
  end
end