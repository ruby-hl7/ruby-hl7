# Prescription Model (RXO)
class HL7::Message::Segment::RXO < HL7::Message::Segment
  weight 1001
  add_field :code_and_label # e.g. "1234-Oxycontin"
end
