module HL7Time
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
    return "" unless fraction_digits > 0

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

# Adding the to_hl7 method to the ruby Date class.
class Date
  # Get a HL7 timestamp (type TS) for a Date instance.
  #
  #  Date.parse('2009-12-02').to_hl7
  #  => "20091202"
  def to_hl7
    strftime("%Y%m%d")
  end
end

# Adding the to_hl7 method to the ruby Time class.
class Time
  include HL7Time
end

# Adding the to_hl7 method to the ruby DateTime class.
class DateTime
  include HL7Time
end

# TODO
# parse an hl7 formatted date
# def Date.from_hl7( hl7_date )
# end

# def Date.to_hl7_short( ruby_date )
# end

# def Date.to_hl7_med( ruby_date )
# end

# def Date.to_hl7_long( ruby_date )
# end
