module HL7
  class Message
    class Segment
      class ERR < HL7::Message::Segment
        weight 2
        add_field :error_code_and_location
        add_field :error_location
        add_field :hl7_error_code
        add_field :severity
        add_field :application_error_code
        add_field :application_error_parameter
        add_field :diagnostic_information
        add_field :user_message
        add_field :help_desk_contact_point, idx: 12
      end
    end
  end
end
