class HL7::Message::Segment::ZPS < HL7::Message::Segment
    weight 12
    add_field :set_id,                  :idx => 1
    add_field :facility_footnote_code,  :idx => 2
    add_field :facility_name,           :idx => 3
    add_field :facility_address,        :idx => 4
    add_field :facility_phone_number,   :idx => 5
    add_field :facility_contact,        :idx => 6
    add_field :facility_director,       :idx => 7
    add_field :facility_lab_code,       :idx => 8
    add_field :facility_clia_number,    :idx => 9
  end
