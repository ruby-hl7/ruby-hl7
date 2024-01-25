class HL7::Message::Segment::TQ1 < HL7::Message::Segment
  weight 2
  add_field :set_id
  add_field :quantity
  add_field :repeat_pattern
  add_field :explicit_time
  add_field :relative_time_and_units
  add_field :service_duration
  add_field :start_time
  add_field :end_time
  add_field :priority
  add_field :condition_text
  add_field :text_instruction
  add_field :conjunction
  add_field :occurrence_duration
  add_field :total_occurrences

  alias_field :start_date, :start_time
  alias_field :end_date, :end_time
end
