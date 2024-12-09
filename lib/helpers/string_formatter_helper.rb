# frozen_string_literal: true

module StringFormatterHelper
  def hl7_batch?(string)
    string.match?(/^FHS/)
  end
end
