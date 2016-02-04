require 'ruby-hl7'
class HL7::Message::Segment::ACC < HL7::Message::Segment
  add_field :accident_date_time do |value|
    convert_to_ts(value)
  end
  add_field :accident_code
  add_field :auto_accident_state
  add_field :accident_job_related_indicator
end
