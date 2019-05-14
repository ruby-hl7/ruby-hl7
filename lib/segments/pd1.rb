# encoding: UTF-8
class HL7::Message::Segment::PD1 < HL7::Message::Segment
  weight 1
  add_field :living_dependency
  add_field :living_arrangement
  add_field :patient_primary_facility
  add_field :patient_primary_care_provider_name_and_id_no
  add_field :student_indicator
  add_field :handicap
  add_field :living_will_code
  add_field :organ_donor_code
  add_field :separate_bill
  add_field :duplicate_patient
  add_field :publicity_code
  add_field :protection_indicator
  add_field :protection_indicator_effective_date do |value|
    convert_to_ts(value)
  end
  add_field :place_of_worship
  add_field :advance_directive_code
  add_field :immunization_registry_status
  add_field :immunization_registry_status_effective_date do |value|
    convert_to_ts(value)
  end
  add_field :publicity_code_effective_date do |value|
    convert_to_ts(value)
  end
  add_field :military_branch
  add_field :military_rank
  add_field :military_status
end
