class HL7::Message::Segment::FTS < HL7::Message::Segment
  weight 101  # at the end
  add_field :custom_field_one
  add_field :custom_field_two
end
