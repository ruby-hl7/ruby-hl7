# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = "ruby-hl7"
  s.version = "1.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mark Guzman"]
  s.description = "A simple library to parse and generate HL7 2.x messages"
  s.email = "ruby-hl7@googlegroups.com"
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc",
  ]

  s.files = `git ls-files`.split "\n"
  s.homepage = "http://github.com/ruby-hl7/ruby-hl7"
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.6")
  s.rubyforge_project = "ruby-hl7"
  s.summary = "Ruby HL7 Library"
  s.license = "MIT"

  s.add_development_dependency "bundler", "~> 2.5"
  s.add_development_dependency "pry"
  s.add_development_dependency "rake", ">= 12.3.3"
  s.add_development_dependency "rake-contrib"
  s.add_development_dependency "rdoc", "~> 6.3"
  s.add_development_dependency "rspec", ">= 3.9.0"
  s.add_development_dependency "rubocop", "~> 1.66"
  s.add_development_dependency "rubocop-performance", "~> 1.22"
  s.add_development_dependency "rubocop-rake", "~> 0.6"
  s.add_development_dependency "rubocop-rspec", "~> 3.1"
  s.add_development_dependency "simplecov", "= 0.16.1"
  s.add_development_dependency "simplecov-html", "~> 0.10.0"
  s.metadata["rubygems_mfa_required"] = "true"
end
