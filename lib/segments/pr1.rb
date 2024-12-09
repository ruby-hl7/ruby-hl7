# encoding: UTF-8
# via https://github.com/bbhoss/ruby-hl7/blob/master/lib/segments/pr1.rb
class HL7::Message::Segment::PR1 < HL7::Message::Segment
  add_field :set_id
  add_field :coding_method
  add_field :code
  add_field :description
  add_field :date_time
  add_field :functional_type
  add_field :minutes
  add_field :anesthesiologist
  add_field :anesthesia_code
  add_field :anesthesia_minutes
  add_field :surgeon
  add_field :practitioner
  add_field :consent_code
  add_field :priority
  add_field :associated_diagnosis_code
  add_field :code_modifier
  add_field :d_r_g_type
  add_field :tissue_type_code
  add_field :identifier
  add_field :action_code
end
