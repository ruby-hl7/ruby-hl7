# GT1: Guarantor segment
# The GT1 segment contains guarantor (e.g., the person or the organization with financial responsibility for payment of a patient account)
# data for patient and insurance billing applications.
class HL7::Message::Segment::GT1 < HL7::Message::Segment
  weight 3 # should occur after PV1 segment
  add_field :set_id, :idx => 1
  add_field :guarantor_name, :idx => 3
  add_field :guarantor_address, :idx => 5
  add_field :guarantor_phone, :idx => 6
  add_field :guarantor_work_phone, :idx => 7
  add_field :guarantor_dob, :idx => 8
  add_field :guarantor_sex, :idx => 9
  add_field :guarantor_type, :idx => 10
end
