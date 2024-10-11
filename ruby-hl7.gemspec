# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ruby-hl7}
  s.version = "1.3.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mark Guzman"]
  s.date = %q{2014-09-09}
  s.description = %q{A simple library to parse and generate HL7 2.x messages}
  s.email = %q{ruby-hl7@googlegroups.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]

  s.files         = `git ls-files`.split "\n"
  s.test_files    = `git ls-files -- {spec}/*`.split "\n"
  s.homepage = %q{http://github.com/ruby-hl7/ruby-hl7}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.6")
  s.rubyforge_project = %q{ruby-hl7}
  s.rubygems_version = %q{1.4.2}
  s.summary = %q{Ruby HL7 Library}
  s.license = "MIT"

  s.add_development_dependency 'bundler', '~> 2.5'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rake', '>= 12.3.3'
  s.add_development_dependency 'rdoc', '~> 6.3'
  s.add_development_dependency 'rspec', '>= 3.9.0'
  s.add_development_dependency 'simplecov', '= 0.16.1'
  s.add_development_dependency 'simplecov-html', '~> 0.10.0'
  s.add_development_dependency 'rake-contrib'
end
