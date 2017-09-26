# encoding: UTF-8
class HL7::Message::Segment::RF1 < HL7::Message::Segment
  weight 0 # should occur after the MSH segment
  add_field :referral_status
  add_field :referral_priority
  add_field :referral_type
  add_field :referral_disposition
  add_field :referral_category
  add_field :originating_referral_identifier
  add_field :effective_date do |value|
    convert_to_ts(value)
  end
  add_field :expiration_date do |value|
    convert_to_ts(value)
  end
  add_field :process_date do |value|
    convert_to_ts(value)
  end
  add_field :referral_reason
  add_field :external_referral_identifier
end
