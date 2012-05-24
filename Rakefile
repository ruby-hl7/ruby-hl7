# $Id$
require 'rubygems'
require 'rake'
require 'rake/rdoctask'
require 'rake/packagetask'
require 'rake/gempackagetask'
require 'rake/contrib/sshpublisher'
require 'rbconfig'
require 'rubyforge'
require 'spec/rake/spectask'
require 'spec/rake/verify_rcov'

$: << './lib'
require 'ruby-hl7'
full_name = "Ruby-HL7"
short_name = full_name.downcase

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
      s.has_rdoc = true
      s.rubyforge_project = short_name
      s.required_ruby_version = '>= 1.8.6'
      s.extra_rdoc_files = %w[README.rdoc LICENSE]
      s.files = FileList["{bin,lib,test_data}/**/*"].to_a
      s.test_files = FileList["{test}/**/test*.rb"].to_a
      s.add_dependency("rake", ">= #{RAKEVERSION}")
      s.add_dependency("rubyforge", ">= #{::RubyForge::VERSION}")
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
  s.rubyforge_project = short_name
  s.description = "A simple library to parse and generate HL7 2.x messages"
  s.files = FileList["{bin,lib,test_data}/**/*"].to_a
  s.require_path = "lib"
  s.test_files = FileList["{test}/**/test*.rb"].to_a
  s.has_rdoc = true
  s.required_ruby_version = '>= 1.8.6'
  s.extra_rdoc_files = %w[README.rdoc LICENSE]
  s.add_dependency("rake", ">= #{RAKEVERSION}")
  s.add_dependency("rubyforge", ">= #{::RubyForge::VERSION}")
end

desc "Run all examples"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_files = FileList['spec/**/*.rb']
end

desc "Run all examples with RCov"
Spec::Rake::SpecTask.new(:spec_with_rcov) do |t|
  t.spec_files = FileList['spec/**/*.rb']
  t.rcov = true
  t.rcov_opts = ['--exclude', "spec,rcov,test"]
end

RCov::VerifyTask.new(:verify_rcov => :spec_with_rcov) do |t|
  t.threshold = 97.13
  t.index_html = 'coverage/index.html'
end

Rake::RDocTask.new do |rd|
  rd.main = "README.rdoc"
  rd.rdoc_files.include("README.rdoc", "LICENSE", "lib/**/*.rb")
  rd.title = "%s (%s) Documentation" % [ full_name, spec.version ]
  rd.rdoc_dir = 'doc'
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_tar = true
end

desc 'Clean up all the extras'
task :clean => [ :clobber_rdoc, :clobber_package ] do
  %w[*.gem ri coverage*].each do |pattern|
    files = Dir[pattern]
    rm_rf files unless files.empty?
  end
end

namespace :forge do
  desc 'Publish RDoc to RubyForge'
  task :publish_docs => [:clean, :rdoc] do
    config = YAML.load(File.read(File.expand_path("~/.rubyforge/user-config.yml")))
    host = "#{config["username"]}@rubyforge.org"
    remote_dir = "/var/www/gforge-projects/#{spec.rubyforge_project}"
    local_dir = 'doc'
    sh %{rsync -av --delete #{local_dir}/ #{host}:#{remote_dir}}
  end

  desc 'Package and upload the release to rubyforge.'
  task :release => [:clean, :package] do |t|
    v = ENV["VERSION"] or abort "Must supply VERSION=x.y.z"
    abort "Versions don't match '#{v}' vs '#{spec.version}'" if v != spec.version.to_s
    pkg = "pkg/#{spec.name}-#{spec.version}"

    if $DEBUG then
      puts "release_id = rf.add_release #{spec.rubyforge_project.inspect}, #{spec.name.inspect}, #{version.inspect}, \"#{pkg}.tgz\""
      puts "rf.add_file #{spec.rubyforge_project.inspect}, #{spec.name.inspect}, release_id, \"#{pkg}.gem\""
    end

    rf = RubyForge.new
    puts "Logging in"
    rf.login

    changes = open("NOTES.md").readlines.join("") if File.exists?("NOTES.md")
    c = rf.userconfig
    c["release_notes"] = spec.description if spec.description
    c["release_changes"] = changes if changes
    c["preformatted"] = true

    files = ["#{pkg}.tgz", "#{pkg}.gem"].compact

    puts "Releasing #{spec.name} v. #{spec.version}"
    rf.add_release spec.rubyforge_project, spec.name, spec.version.to_s, *files
  end
end

desc 'Install the package as a gem'
task :install_gem => [:clean, :package] do
  sh "sudo gem install pkg/*.gem"
end
