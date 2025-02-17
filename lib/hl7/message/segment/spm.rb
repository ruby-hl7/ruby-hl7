# frozen_string_literal: true

class HL7::Message::Segment::SPM < HL7::Message::Segment
  # Weight doesn't really matter, since this always occurs as a child
  # of an OBR segment.
  weight 100 # fixme
  has_children [:OBX]
  add_field :set_id
  add_field :specimen_id
  add_field :specimen_parent_ids
  add_field :specimen_type
  add_field :specimen_type_modifier
  add_field :specimen_additives
  add_field :specimen_collection_method
  add_field :specimen_source_site
  add_field :specimen_source_site_modifier
  add_field :specimen_collection_site
  add_field :specimen_role
  add_field :specimen_collection_amount
  add_field :grouped_specimen_count
  add_field :specimen_description
  add_field :specimen_handling_code
  add_field :specimen_risk_code
  add_field :specimen_collection_date
  add_field :specimen_received_date
  add_field :specimen_expiration_date
  add_field :specimen_availability
  add_field :specimen_reject_reason
  add_field :specimen_quality
  add_field :specimen_appropriateness
  add_field :specimen_condition
  add_field :specimen_current_quantity
  add_field :number_of_specimen_containers
  add_field :container_type
  add_field :container_condition
  add_field :specimen_child_role
end
