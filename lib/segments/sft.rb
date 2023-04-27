module HL7
  class Message
    class Segment
      class SFT < HL7::Message::Segment
        weight 0
        add_field :software_vendor_organization
        add_field :software_certified_version_or_release_number # NEW longest method name ever.
        add_field :software_product_name
        add_field :software_binary_id
        add_field :software_product_information
        add_field :software_install_date
      end
    end
  end
end
