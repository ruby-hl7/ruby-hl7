# This module includes methods for storing segments inside segments.
# has_children(child_types) defines three methods dynamically.

module HL7::Message::SegmentListStorage
  attr_reader :child_types

  def add_child_type(child_type)
    if defined?(@child_types)
      @child_types << child_type.to_sym
    else
      has_children [child_type.to_sym]
    end
  end

private

  # allows a segment to store other segment objects
  # used to handle associated lists like one OBR to many OBX segments
  def has_children(child_types)
    @child_types = child_types

    define_method_child_types
    define_method_children
    define_method_accepts
  end

  def define_method_child_types
    define_method(:child_types) do
      self.class.child_types
    end
  end

  def define_method_accepts
    class_eval do
      define_method(:accepts?) do |t|
        t = t.to_sym if t.respond_to?(:to_sym)
        !!child_types.index(t)
      end
    end
  end

  def define_method_children
    class_eval do
      define_method(:children) do
        unless defined?(@my_children)
          p = self
          @my_children ||= []
          @my_children.instance_eval do
            @parental = p
            alias :old_append :<<

            def <<(value)
              # do nothing if value is nil
              return unless value

              # make sure it's an array
              value = [value].flatten
              value.map {|item| append(item) }
            end

            def append(value)
              unless value && value.is_a?(HL7::Message::Segment)
                raise HL7::Exception.new("attempting to append non-segment to a segment list")
              end

              value.segment_parent = @parental
              k = @parental
              k = k.segment_parent while k && k.segment_parent && !k.segment_parent.is_a?(HL7::Message)
              k.segment_parent << value if k && k.segment_parent
              old_append(value)
            end
          end
        end
        @my_children
      end
    end
  end
end
