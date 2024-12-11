# frozen_string_literal: true

class HL7::Message::Segment::PR1 < HL7::Message::Segment
  add_field :set_id, :idx => 1
  add_field :coding_method, :idx => 2
  add_field :code, :idx => 3
  add_field :description, :idx => 4
  add_field :date_time, :idx => 5 do |value|
    convert_to_ts(value)
  end
  add_field :functional_type, :idx => 6
  add_field :minutes, :idx => 7
  add_field :anesthesiologist, :idx => 8
  add_field :anesthesia_code, :idx => 9
  add_field :anesthesia_minutes, :idx => 10
  add_field :surgeon, :idx => 11
  add_field :practitioner, :idx => 12
  add_field :consent_code, :idx => 13
  add_field :priority, :idx => 14
  add_field :associated_diagnosis_code, :idx => 15
  add_field :code_modifier, :idx => 16
  add_field :drg_type, :idx => 17
  add_field :tissue_type_code, :idx => 18
  add_field :identifier, :idx => 19
  add_field :action_code, :idx => 20
  add_field :drg_procedure_determination_status, :idx => 21
  add_field :drg_procedure_relevance, :idx => 22
  add_field :treating_organizational_unit, :idx => 23
  add_field :respiratory_within_surgery, :idx => 24
  add_field :parent_procedure_id, :idx => 25
end
