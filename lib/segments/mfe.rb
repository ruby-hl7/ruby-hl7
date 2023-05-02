module HL7
  class Message
    class Segment
      class MFE < HL7::Message::Segment
        weight 0
        add_field :record_level_event_code
        add_field :mfn_control_id
        add_field :effective_date_time do |value|
          convert_to_ts(value)
        end
        add_field :primary_key_value
        add_field :primary_key_value_type
      end
    end
  end
end
