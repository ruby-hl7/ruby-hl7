module HL7
  class Message
    class Segment
      class PRD < HL7::Message::Segment
        weight 2
        add_field :provider_role
        add_field :provider_name
        add_field :provider_address
        add_field :provider_location
        add_field :provider_communication_information
        add_field :preferred_method_of_contact
        add_field :provider_identifiers
        add_field :effective_start_date_of_provider_role do |value|
          convert_to_ts(value)
        end
        add_field :effective_end_date_of_provider_role do |value|
          convert_to_ts(value)
        end
      end
    end
  end
end
