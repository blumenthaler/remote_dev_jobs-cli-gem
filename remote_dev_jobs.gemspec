# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'remote_dev_jobs/version'

Gem::Specification.new do |spec|
  spec.name          = "remote_dev_jobs"
  spec.version       = RemoteDevJobs::VERSION
  spec.authors       = ["Seth Goldberg"]
  spec.email         = ["seth@jsgold.co"]

  spec.summary       = %q{A Ruby gem for finding remote web developer jobs.}
  spec.description   = %q{This gem searches several sites for remote web development positions.}
  spec.homepage      = "https://github.com/jsgoldb/remote-dev-jobs-cli-gem.git"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = ["remote-jobs"]
  spec.require_paths = ["lib", "lib/remote_dev_jobs"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'pry', '~> 0'
  spec.add_dependency 'require_all'
  spec.add_development_dependency 'nokogiri'
  spec.add_development_dependency 'launchy'
  spec.add_development_dependency 'rspec'
end
