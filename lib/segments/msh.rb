class HL7::Message::Segment::MSH < HL7::Message::Segment
  weight(-1) # the msh should always start a message
  add_field :enc_chars
  add_field :sending_app
  add_field :sending_facility
  add_field :recv_app
  add_field :recv_facility
  add_field :time do |value|
    convert_to_ts(value)
  end
  add_field :security
  add_field :message_type
  add_field :message_control_id
  add_field :processing_id
  add_field :version_id
  add_field :seq
  add_field :continue_ptr
  add_field :accept_ack_type
  add_field :app_ack_type
  add_field :country_code
  add_field :charset
  add_field :principal_language_of_message
  add_field :alternate_character_set_handling_scheme
  add_field :message_profile_identifier
  add_field :sending_responsible_org
  add_field :receiving_responsible_org
  add_field :sending_network_address
  add_field :receiving_network_address
end
