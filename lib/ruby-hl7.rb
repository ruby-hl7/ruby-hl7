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

require 'rubygems'
require 'stringio'
require 'date'
require 'configuration'

module HL7 # :nodoc:
  VERSION = '1.3.3'.freeze
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
module HL7
  class Exception < StandardError
  end
end

# Parsing failed
module HL7
  class ParseError < HL7::Exception
  end
end

# Attempting to use an invalid indice
module HL7
  class RangeError < HL7::Exception
  end
end

# Attempting to assign invalid data to a field
module HL7
  class InvalidDataError < HL7::Exception
  end
end

# Attempting to add an empty segment
# This error per configuration setting
module HL7
  class EmptySegmentNotAllowed < HL7::ParseError
  end
end

require 'message_parser'
require 'message'
require 'segment_list_storage'
require 'segment_generator'
require 'segment_fields'
require 'segment'
require 'segment_default'

require 'core_ext/date_time'
require 'core_ext/string'
