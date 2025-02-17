# frozen_string_literal: true

class HL7::Message::Segment::SCH < HL7::Message::Segment
  weight 0
  add_field :placer_appointment_id
  add_field :filler_appointment_id
  add_field :occurance_number
  add_field :placer_group_number
  add_field :schedule_id
  add_field :event_reason
  add_field :appointment_reason
  add_field :appointment_type
  add_field :appointment_duration
  add_field :appointment_duration_units
  add_field :appointment_timing_quantity
  add_field :placer_contact_person
  add_field :placer_contact_phone_number
  add_field :placer_contact_address
  add_field :placer_contact_location
  add_field :filler_contact_person
  add_field :filler_contact_phone_number
  add_field :filler_contact_address
  add_field :filler_contact_location
  add_field :entered_by_person
  add_field :entered_by_phone_number
  add_field :entered_by_location
  add_field :parent_placer_appointment_id
  add_field :parent_filler_appointment_id
  add_field :filler_status_code
  add_field :placer_order_number
  add_field :filler_order_number
end
