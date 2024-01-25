# $Id$
require 'rubygems'
require 'rake'
require 'rdoc/task'
require 'rubygems/package_task'
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
RAKEVERSION = "12.3.3"

# Many of these tasks were garnered from zenspider's Hoe
# just forced to work my way

desc 'Default: Run all examples'
task :default => :spec

spec = Gem::Specification.new do |s|
  s.homepage = "https://github.com/ruby-hl7/ruby-hl7"
  s.platform = Gem::Platform::RUBY
  s.summary = "Ruby HL7 Library"
  s.description = "A simple library to parse and generate HL7 2.x messages"
  s.files = FileList["{bin,lib,test_data}/**/*"].to_a
  s.require_path = "lib"
  s.test_files = FileList["{test}/**/test*.rb"].to_a
  s.has_rdoc = true
  s.required_ruby_version = '>= 1.8.6'
  s.extra_rdoc_files = %w[README.rdoc LICENSE]
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

RDoc::Task.new do |rd|
  rd.main = "README.rdoc"
  rd.rdoc_files.include("README.rdoc", "LICENSE", "lib/**/*.rb")
  rd.title = "%s (%s) Documentation" % [ full_name, spec.version ]
  rd.rdoc_dir = 'doc'
end

Gem::PackageTask.new(spec) do |pkg|
  pkg.need_tar = true
end

desc 'Clean up all the extras'
task :clean => [ :clobber_rdoc, :clobber_package ] do
  %w[*.gem ri coverage*].each do |pattern|
    files = Dir[pattern]
    rm_rf files unless files.empty?
  end
end

desc 'Install the package as a gem'
task :install_gem => [:clean, :package] do
  sh "sudo gem install pkg/*.gem"
end
