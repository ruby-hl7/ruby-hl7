# encoding: UTF-8
class HL7::Message::Segment::NK1 < HL7::Message::Segment
  add_field :set_id
  add_field :name
  add_field :relationship
  add_field :address
  add_field :phone_number
  add_field :organization_name, :idx => 13
  add_field :primary_language, :idx => 20
  add_field :contact_persons_name, :idx => 30
  add_field :contact_persons_telephone_number
  add_field :contact_persons_address
end
