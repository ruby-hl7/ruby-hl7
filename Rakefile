# $Id$
require 'rubygems'
require 'rake'
require 'rubygems/package_task'
require 'rake/contrib/sshpublisher'
require 'rbconfig'
require 'rspec'
require 'rspec/core/rake_task'
require 'simplecov'

$: << './lib'
require 'ruby-hl7'
require 'message_parser'
require 'message'
require 'segment_list_storage'
require 'segment_generator'
require 'segment'

full_name = "Ruby-HL7"
short_name = full_name.downcase
RAKEVERSION = 11.3

# Many of these tasks were garnered from zenspider's Hoe
# just forced to work my way

desc 'Default: Run all examples'
task :default => :spec

if RUBY_VERSION < '1.9.1'
  begin
    require 'jeweler'
    Jeweler::Tasks.new do |s|
      s.name = short_name
      s.full_name
      s.summary = "Ruby HL7 Library"
      s.authors = ["Mark Guzman"]
      s.email = "ruby-hl7@googlegroups.com"
      s.homepage = "http://github.com/ruby-hl7/ruby-hl7"
      s.description = "A simple library to parse and generate HL7 2.x messages"
      s.require_path = "lib"
      s.required_ruby_version = '>= 1.8.6'
      s.files = FileList["{bin,lib,test_data}/**/*"].to_a
      s.test_files = FileList["{test}/**/test*.rb"].to_a
      s.add_dependency("rake", ">= #{RAKEVERSION}")
    end
  rescue LoadError
    puts "Jeweler, or one of its dependencies, is not available. Install it with: sudo gem install jeweler"
  end
end


spec = Gem::Specification.new do |s|
  s.name = short_name
  s.full_name
  s.version = HL7::VERSION
  s.author = "Mark Guzman"
  s.email = "ruby-hl7@googlegroups.com"
  s.homepage = "https://github.com/ruby-hl7/ruby-hl7"
  s.platform = Gem::Platform::RUBY
  s.summary = "Ruby HL7 Library"
  s.description = "A simple library to parse and generate HL7 2.x messages"
  s.files = FileList["{bin,lib,test_data}/**/*"].to_a
  s.require_path = "lib"
  s.test_files = FileList["{test}/**/test*.rb"].to_a
  s.required_ruby_version = '>= 1.8.6'
  s.add_dependency("rake", ">= #{RAKEVERSION}")
end

desc "Run all examples"
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = 'spec/**/*.rb'
  spec.ruby_opts = '-w'
end

desc "Run all examples with SimpleCov"
RSpec::Core::RakeTask.new(:spec_with_simplecov) do |spec|
  ENV['COVERAGE'] = 'true'
  spec.pattern = 'spec/**/*.rb'
end

Gem::PackageTask.new(spec) do |pkg|
  pkg.need_tar = true
end

desc 'Clean up all the extras'
task :clean do
  %w[*.gem ri coverage*].each do |pattern|
    files = Dir[pattern]
    rm_rf files unless files.empty?
  end
end

desc 'Install the package as a gem'
task :install_gem => [:clean, :package] do
  sh "sudo gem install pkg/*.gem"
end
