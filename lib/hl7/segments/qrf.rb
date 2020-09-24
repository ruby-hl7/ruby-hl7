# encoding: UTF-8
class HL7::Message::Segment::QRF < HL7::Message::Segment
  weight 85
  add_field :where_subject_filter
  add_field :when_start_date
  add_field :when_end_date
  add_field :what_user_qualifier
  add_field :other_qry_subject_filter
  add_field :which_date_qualifier
  add_field :which_date_status_qualifier
  add_field :date_selection_qualifier
  add_field :when_timing_qualifier
  add_field :search_confidence_threshold
end
