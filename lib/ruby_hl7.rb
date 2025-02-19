# frozen_string_literal: true

#= ruby-hl7.rb
# Ruby HL7 is designed to provide a simple, easy to use library for
# parsing and generating HL7 (2.x) messages.
#
#
# Author:    Mark Guzman  (mailto:segfault@hasno.info)
#
# Copyright: (c) 2006-2009 Mark Guzman
#
# License:   BSD
#
#  $Id$
#
# == License
# see the LICENSE file
#

require "rubygems"
require "stringio"
require "date"
require "hl7/configuration"
require "helpers/time_formatter_helper"
require "zeitwerk"

require_relative "hl7_inflector"
require_relative "core_ext/date"
require_relative "core_ext/date_time"
require_relative "core_ext/string"
require_relative "core_ext/time"

module RubyHl7
end

module HL7 # :nodoc:
  # Gives access to the current Configuration.
  def self.configuration
    @configuration ||= Configuration.new
  end

  # Allows easy setting of multiple configuration options. See Configuration
  # for all available options.
  def self.configure
    config = configuration
    yield(config)
  end
end

# Encapsulate HL7 specific exceptions
class HL7::Exception < StandardError
end

# Parsing failed
class HL7::ParseError < HL7::Exception
end

# Attempting to use an invalid indice
class HL7::RangeError < HL7::Exception
end

# Attempting to assign invalid data to a field
class HL7::InvalidDataError < HL7::Exception
end

# Attempting to add an empty segment
# This error per configuration setting
class HL7::EmptySegmentNotAllowed < HL7::ParseError
end

loader = Zeitwerk::Loader.for_gem(:warn_on_extra_files => false)
loader.inflector = Hl7Inflector.new
loader.inflector.inflect(
  # NOTE: These constants are loaded through a custom inflector temporarily to avoid refactoring them all at once
  "hl7_messages" => "HL7MESSAGES",
  "version" => "VERSION"
)
loader.push_dir("#{__dir__}/../lib")
loader.push_dir("#{__dir__}/../lib/helpers", :namespace => Object)
loader.push_dir("#{__dir__}/../lib/core_ext", :namespace => Object)

loader.setup
loader.eager_load
