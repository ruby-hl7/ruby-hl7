module HL7
  class Message
    class Segment
      class RGS < HL7::Message::Segment
        weight 3
        add_field :set_id
        add_field :segment_action_code
        add_field :resource_group_id
      end
    end
  end
end
