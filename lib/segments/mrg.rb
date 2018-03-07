# encoding: UTF-8
require 'ruby-hl7'
class HL7::Message::Segment::MRG < HL7::Message::Segment
  weight 200 # should occur after the msh segment
  add_field :prior_patient_id_list
  add_field :alter_patient_id
  add_field :prior_patient_account_num
  add_field :prior_patient_id
  add_field :prior_visit_num
  add_field :prior_alter_visit_num
  add_field :prior_patient_name
end