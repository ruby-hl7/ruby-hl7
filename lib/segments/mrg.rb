# encoding: UTF-8
require 'ruby-hl7'
class HL7::Message::Segment::MRG < HL7::Message::Segment
  weight 4
  add_field :patient_id, :idx => 1
  add_field :alt_patient_id, :idx => 2
  add_field :patient_account_number, :idx => 3
  add_field :external_patient_id, :idx => 4
  add_field :visit_id, :idx => 5
  add_field :alt_visit_id, :idx => 6
  add_field :patient_name, :idx => 7
end
