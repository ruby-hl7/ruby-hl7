# frozen_string_literal: true

# $Id$
require "rubygems"
require "rake"
require "rdoc/task"
require "rubygems/package_task"
require "rbconfig"
require "rspec"
require "rspec/core/rake_task"
require "simplecov"
require_relative "lib/ruby_hl7/version"

$: << "./lib"
require "ruby_hl7"
require "hl7/message_batch_parser"
require "hl7/message"
require "hl7/message/delimiter"
require "hl7/message/segment_list_storage"
require "hl7/message/segment_fields"
require "hl7/message/segment_generator"
require "hl7/message/segment"
require "hl7/message/segment/default"
RAKEVERSION = "12.3.3"

# Many of these tasks were garnered from zenspider's Hoe
# just forced to work my way

desc "Default: Run all examples"
task :default => :spec

spec = Gem::Specification.new do |s|
  s.name = "ruby-hl7"
  s.version = RubyHl7::VERSION
  s.homepage = "https://github.com/ruby-hl7/ruby-hl7"
  s.platform = Gem::Platform::RUBY
  s.summary = "Ruby HL7 Library"
  s.description = "A simple library to parse and generate HL7 2.x messages"
  s.authors = ["Mark Guzman", "Enrique Carlos Mogollan", "Lucas Montorio"]
  s.files = FileList["{bin,lib,test_data}/**/*"].to_a
  s.require_path = "lib"
  s.test_files = FileList["{test}/**/test*.rb"].to_a
  s.required_ruby_version = ">= 1.8.6"
  s.add_runtime_dependency("rake", ">= #{RAKEVERSION}")
end

desc "Run all examples"
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = "spec/**/*.rb"
  spec.ruby_opts = "-w"
end

desc "Run all examples with SimpleCov"
RSpec::Core::RakeTask.new(:spec_with_simplecov) do |spec|
  ENV["COVERAGE"] = "true"
  spec.pattern = "spec/**/*.rb"
end

Gem::PackageTask.new(spec) do |pkg|
  pkg.need_tar = true
end

desc "Clean up all the extras"
task :clean => %i[clobber_rdoc clobber_package] do
  %w[*.gem ri coverage*].each do |pattern|
    files = Dir[pattern]
    rm_rf files unless files.empty?
  end
end

desc "Install the package as a gem"
task :install_gem => %i[clean package] do
  sh "sudo gem install pkg/*.gem"
end
