# encoding: UTF-8
require 'ruby-hl7'
class HL7::Message::Segment::EVN < HL7::Message::Segment
  weight 0 # should occur after the MSH segment
  add_field :type_code, :idx=>1
  add_field :recorded_date, :idx=>2
  add_field :planned_date, :idx=>3
  add_field :reason_code, :idx=>4
  add_field :operator_id, :idx=>5
  add_field :event_occurred, :idx=>6
  add_field :event_facility, :idx=>6
end
