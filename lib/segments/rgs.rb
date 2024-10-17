# frozen_string_literal: true

class HL7::Message::Segment::RGS < HL7::Message::Segment
  weight 3
  add_field :set_id
  add_field :segment_action_code
  add_field :resource_group_id
end
