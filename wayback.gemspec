# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wayback/version'

Gem::Specification.new do |spec|
  spec.add_dependency 'faraday', ['~> 0.8', '< 0.10']
  spec.add_dependency 'faraday_middleware', ['~> 0.9', '< 0.10']
  spec.add_dependency 'json', '~> 1.8'
  spec.add_development_dependency 'bundler', '~> 1.0'
  spec.authors = ["Greg Leuch"]
  # spec.cert_chain  = ['certs/gleuch.pem']
  spec.description = %q{A Ruby interface to the Archive.org's Wayback Machine JSON and Memento APIs.}
  spec.email = ['greg@xolator.com']
  spec.files = %w(.yardopts CHANGELOG.md CONTRIBUTING.md LICENSE.md README.md Rakefile wayback.gemspec)
  spec.files += Dir.glob("lib/**/*.rb")
  spec.files += Dir.glob("spec/**/*")
  spec.homepage = 'http://github.com/XOlator/wayback_gem/'
  spec.licenses = ['MIT']
  spec.name = 'wayback'
  spec.require_paths = ['lib']
  spec.required_rubygems_version = '>= 1.3.6'
  # spec.signing_key = File.expand_path("~/.gem/private_key.pem") if $0 =~ /gem\z/
  spec.summary = spec.description
  spec.test_files = Dir.glob("spec/**/*")
  spec.version = Wayback::Version
end