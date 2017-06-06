# encoding: UTF-8
class HL7::Message::Segment::QRD < HL7::Message::Segment
  weight 84
  add_field :query_date
  add_field :query_format_code
  add_field :query_priority
  add_field :query_id
  add_field :deferred_response_type
  add_field :deferred_response_date
  add_field :quantity_limited_request
  add_field :who_subject_filter
  add_field :what_subject_filter
  add_field :what_department_code
  add_field :what_data_code
  add_field :query_results_level
end
