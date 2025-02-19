# frozen_string_literal: true

# Adding the to_hl7 method to the ruby Time class.
class Time
  include Hl7Time
end
