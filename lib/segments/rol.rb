# encoding: UTF-8
require 'ruby-hl7'
class HL7::Message::Segment::ROL < HL7::Message::Segment
  add_field :role_instance
  add_field :action_code
  add_field :role
  add_field :role_person
  add_field :role_begin
  add_field :role_end
  add_field :role_duration
  add_field :role_action_reason
  add_field :unknown_one
  add_field :unknown_two
  add_field :role_address
  add_field :role_phone
end
