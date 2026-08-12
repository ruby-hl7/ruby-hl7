# frozen_string_literal: true

module HL7
  # This class enables detailed configuration of the HL7 parser services.
  #
  # By calling
  #
  #   HL7.configuration # => instance of HL7::Configuration
  #
  # or
  #   HL7.configure do |config|
  #     config # => instance of HL7::Configuration
  #   end
  #
  # you are able to perform configuration updates.
  #
  # Setting the keys with this Configuration
  #
  #   HL7.configure do |config|
  #     config.empty_segment_is_error  = false
  #   end
  #
  class Configuration
    attr_accessor :empty_segment_is_error

    def initialize # :nodoc:
      @empty_segment_is_error = true
    end
  end
end
