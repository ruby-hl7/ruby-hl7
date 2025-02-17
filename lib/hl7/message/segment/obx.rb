# frozen_string_literal: true

class HL7::Message::Segment::OBX < HL7::Message::Segment
  weight 90
  has_children [:NTE]
  add_field :set_id
  add_field :value_type
  add_field :observation_id
  add_field :observation_sub_id
  add_field :observation_value
  add_field :units
  add_field :references_range
  add_field :abnormal_flags
  add_field :probability
  add_field :nature_of_abnormal_test
  add_field :observation_result_status
  add_field :effective_date_of_reference_range do |value|
    convert_to_ts(value)
  end
  add_field :user_defined_access_checks
  add_field :observation_date do |value|
    convert_to_ts(value)
  end
  add_field :producer_id
  add_field :responsible_observer
  add_field :observation_method
  add_field :equipment_instance_id
  add_field :analysis_date do |value|
    convert_to_ts(value)
  end
  add_field :observation_site
  add_field :observation_instance_id
  add_field :mood_code
  add_field :performing_organization_name
  add_field :performing_organization_address
  add_field :performing_organization_medical_director

  def correction?
    observation_result_status == "C"
  end
end
