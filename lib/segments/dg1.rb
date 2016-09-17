module HL7
  class Message::Segment::DG1 < HL7::Message::Segment
    weight 92
    add_field :set_id,                    :idx => 1
    add_field :diagnosis_coding_method,   :idx => 2
    add_field :diagnosis_code,            :idx => 3
    add_field :diagnosis_date_time,       :idx => 4 do |value|
      convert_to_ts(value)
    end
    add_field :diagnosis_type,            :idx => 5
    add_field :major_diagnostic_category, :idx => 6
    add_field :diagnosis_related_group,   :idx => 7
    add_field :drg_approval_indicator,    :idx => 8
    add_field :drg_grouper_review_code,   :idx => 9
    add_field :outlier_type,              :idx => 10
    add_field :outlier_days,              :idx => 11
    add_field :outlier_cost,              :idx => 12
    add_field :grouper_version_and_type,  :idx => 13
    add_field :diagnosis_priority,        :idx => 14
    add_field :diagnosis_clinician,       :idx => 15
    add_field :diagnosis_classification,  :idx => 16
    add_field :confidential_indicator,    :idx => 17
    add_field :attestation_date_time,     :idx => 18 do |value|
      convert_to_ts(value)
    end
    
    private
    
    def self.convert_to_ts(value) #:nodoc:
      if value.is_a?(Time) or value.is_a?(Date)
        value.to_hl7
      else
        value
      end
    end
  end
end
