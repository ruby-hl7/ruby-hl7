class HL7::Message::Segment::FIL < HL7::Message::Segment
  add_field :set_id
  add_field :data_type # PDF
  add_field :embedded_pdf
end
