# frozen_string_literal: true

require "zeitwerk"

class Hl7Inflector < Zeitwerk::Inflector
  def camelize(basename, abspath)
    if basename == "hl7"
      "HL7"
    elsif abspath =~ %r{hl7/message/segment/} && basename != "default"
      "#{basename.upcase}"
    else
      super
    end
  end
end
