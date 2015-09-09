
class HL7::Message::Segment::TQ1 < HL7::Message::Segment
  weight 2
  add_field :set_id, idx: 1
  add_field :quantity, idx: 2
  add_field :repeat_pattern, idx: 3
  add_field :explicit_time, idx: 4
  add_field :relative_time_and_units, idx: 5
  add_field :service_duration, idx: 6
  add_field :start_date_time, idx: 7
  add_field :end_date_time, idx: 8
  add_field :priority, idx: 9
  add_field :condition_text, idx: 10
  add_field :text_instruction, idx: 11
  add_field :conjunction, idx: 12
  add_field :occurence_duration, idx: 13
  add_field :total_occurrences, idx: 14
end
