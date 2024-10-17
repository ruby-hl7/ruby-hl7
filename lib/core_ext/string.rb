# frozen_string_literal: true

# Adding a helper to the String class for the batch parse.
class String
  def hl7_batch?
    !!match(/^FHS/)
  end
end
