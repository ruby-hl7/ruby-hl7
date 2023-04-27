module HL7
  class Message
    class Segment
      class FTS < HL7::Message::Segment
        weight 1001 # at the end
        add_field :file_batch_count
        add_field :file_trailer_comment
      end
    end
  end
end
