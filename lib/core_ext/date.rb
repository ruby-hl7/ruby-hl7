# frozen_string_literal: true

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
