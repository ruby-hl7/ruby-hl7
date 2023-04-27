module HL7
  class Message
    class Segment
      class MSA < HL7::Message::Segment
        weight 1 # should occur after the msh segment
        add_field :ack_code
        add_field :control_id
        add_field :text
        add_field :expected_seq
        add_field :delayed_ack_type
        add_field :error_cond
      end
    end
  end
end
