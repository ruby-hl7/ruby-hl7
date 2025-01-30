# frozen_string_literal: true

module TimeFormatterHelper
  class ValueTypeNotSupportedError < StandardError; end

  # Get an HL7 timestamp (type TS) for a Time or DateTime instance.
  #
  # fraction_digits:: specifies a number of digits of fractional seconds.
  #                   Its default value is 0.
  #  hl7_formatted_timestamp(Time.parse('01:23'))
  #  => "20091202012300"
  #  hl7_formatted_timestamp(Time.now, 3)
  #  => "20091202153652.302"
  def hl7_formatted_timestamp(value, fraction_digits = 0)
    raise ValueTypeNotSupportedError, "Value must be an instance of Time or DateTime" unless value.is_a?(Time) || value.is_a?(DateTime)

    value.strftime("%Y%m%d%H%M%S") + hl7_formatted_fractions(value, fraction_digits)
  end

  # Get an HL7 timestamp (type TS) for a Date instance.
  def hl7_formatted_date(value)
    raise ValueTypeNotSupportedError, "Value must be an instance of Date" unless value.is_a?(Date)

    value.strftime("%Y%m%d")
  end

  def parsed_hl7_date(value)
    raise ValueTypeNotSupportedError, "Value must be an instance of String" unless value.is_a?(String)

    Date.parse(value)
  end

  def parsed_hl7_timestamp(value)
    raise ValueTypeNotSupportedError, "Value must be an instance of String" unless value.is_a?(String)

    Time.parse(value)
  end

private

  def hl7_formatted_fractions(value, fraction_digits = 0)
    return "" unless fraction_digits.positive?

    time_fraction =  if value.respond_to?(:usec)
      value.usec
    else
      value.sec_fraction.to_f * 1_000_000
    end

    answer = ".#{format("%06d", time_fraction)}"
    answer += "0" * ((fraction_digits - 6)).abs if fraction_digits > 6
    answer[0, 1 + fraction_digits]
  end
end
