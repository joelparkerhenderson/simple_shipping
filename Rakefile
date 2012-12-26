# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "simple_shipping"
  gem.homepage = "http://github.com/greyblake/simple_shipping"
  gem.license = "MIT"
  gem.summary = %Q{Interacts with UPS and FedEx APIs}
  gem.description = %Q{This gem uses the APIs provided by UPS and FedEx to
    service various requests on behalf of an application. In particular, it is
    used to create shipping labels so a customer can send a package
    postage-free}
  gem.email = "blake131313@gmail.com"
  gem.authors = ["Potapov Sergey", "Zachary Belzer"]
  # dependencies defined in Gemfile
end

# Jeweler functions
def read_gem_version
  open('VERSION', 'r'){ |f| f.read }.strip
end

def gem_version
  @gem_version ||= read_gem_version
end

def gem_file_name
  "simple_shipping-#{gem_version}.gem"
end

namespace :gemfury do
  desc "Build version #{gem_version} into the pkg directory and upload to GemFury"
  task :push => [:build] do
    sh "fury push pkg/#{gem_file_name} --as=TMXCredit"
  end
end

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

require 'reek/rake/task'
Reek::Rake::Task.new do |t|
  t.fail_on_error = true
  t.verbose = false
  t.source_files = 'lib/**/*.rb'
end

require 'roodi'
require 'roodi_task'
RoodiTask.new do |t|
  t.verbose = false
end

task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new
