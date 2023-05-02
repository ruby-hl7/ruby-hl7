module HL7
  class Message
    class Segment
      class NTE < HL7::Message::Segment
        weight 4
        add_field :set_id, idx: 1
        add_field :source, idx: 2
        add_field :comment, idx: 3
        add_field :comment_type, idx: 4
      end
    end
  end
end
