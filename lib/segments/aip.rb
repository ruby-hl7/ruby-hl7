module HL7
  class Message
    class Segment
      class AIP < HL7::Message::Segment
        weight 0
        add_field :set_id
        add_field :segment_action_code
        add_field :personnel_resource_id
        add_field :resource_role
        add_field :resource_group
        add_field :start_date_time
        add_field :start_date_time_offset
        add_field :start_date_time_offset_units
        add_field :duration
        add_field :duration_units
        add_field :allow_substitution_code
        add_field :filler_status_code
      end
    end
  end
end
