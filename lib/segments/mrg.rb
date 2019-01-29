class HL7::Message::Segment::MRG < HL7::Message::Segment
  weight 4
  add_field :prior_patient_identifier_list
  add_field :prior_alternate_patient_id
  add_field :prior_patient_account_number
  add_field :prior_patient_id
  add_field :prior_visit_number
  add_field :prior_alternate_visit_id
  add_field :prior_patient_name
end
