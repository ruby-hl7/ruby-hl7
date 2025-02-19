# frozen_string_literal: true

require 'hl7_time'

# Adding the to_hl7 method to the ruby DateTime class.
class DateTime
  include Hl7Time
end
