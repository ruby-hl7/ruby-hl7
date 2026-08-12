# frozen_string_literal: true

class HL7::Message::Segment::MFI < HL7::Message::Segment
  weight 0
  add_field :master_file_identifier
  add_field :master_file_application_identifier
  add_field :file_level_event_code
  add_field :entered_date_time do |value|
    convert_to_ts(value)
  end
  add_field :effective_date_time do |value|
    convert_to_ts(value)
  end
  add_field :response_level_code
end
