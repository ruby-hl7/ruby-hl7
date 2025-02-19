# frozen_string_literal: true

module Hl7Time
  # Get a HL7 timestamp (type TS) for a Time instance.
  #
  # fraction_digits:: specifies a number of digits of fractional seconds.
  #                   Its default value is 0.
  #  Time.parse('01:23').to_hl7
  #  => "20091202012300"
  #  Time.now.to_hl7(3)
  #  => "20091202153652.302"
  def to_hl7(fraction_digits = 0)
    strftime("%Y%m%d%H%M%S") + hl7_fractions(fraction_digits)
  end

  private

  def hl7_fractions(fraction_digits = 0)
    return "" unless fraction_digits.positive?

    time_fraction =  hl7_time_fraction
    answer = ".#{format("%06d", time_fraction)}"
    answer += "0" * ((fraction_digits - 6)).abs if fraction_digits > 6
    answer[0, 1 + fraction_digits]
  end

  def hl7_time_fraction
    if respond_to? :usec
      usec
    else
      sec_fraction.to_f * 1_000_000
    end
  end
end
