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
    attr_accessor :empty_segment_is_error, :enable_repetitions, :preserve_data_types

    def initialize #:nodoc:
      @empty_segment_is_error = true
      @enable_repetitions = false
      @preserve_data_types = false
    end

    def enable_repetitions=(enabled)
      if enabled && !preserve_data_types
        raise ArgumentError, "`enable_repetitions` requires `preserve_data_types` to be set to `true`"
      end
      @enable_repetitions = enabled
    end
  end
end
