# frozen_string_literal: true

require "simplecov"

if ENV["COVERAGE"]
  SimpleCov.start do
    add_filter "/test/"
    add_filter "/spec/"
  end
end

# ruby-hl7 loads the rest of the files in lib
require File.expand_path("../lib/ruby_hl7", __dir__)
require File.expand_path("../lib/test/hl7_messages", __dir__)

RSpec.configure do |config|
  config.include TimeFormatterHelper, :type => :helper
end
