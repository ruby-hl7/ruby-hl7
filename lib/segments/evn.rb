class HL7::Message::Segment::EVN < HL7::Message::Segment
  weight 0 # should occur after the MSH segment
  add_field :type_code
  add_field :recorded_date do |value|
    convert_to_ts(value)
  end
  add_field :planned_date do |value|
    convert_to_ts(value)
  end
  add_field :reason_code
  add_field :operator_id
  add_field :event_occurred do |value|
    convert_to_ts(value)
  end
  add_field :event_facility
end
