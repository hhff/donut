# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'donut/version'

Gem::Specification.new do |spec|
  spec.name          = "donut"
  spec.version       = Donut::VERSION
  spec.authors       = ["Hugh Francis"]
  spec.email         = ["me@hughfrancis.me"]

  spec.summary       = %q{Donut is a tool for orchestrating builds, testing and installation across multi-app projects.}
  spec.description   = %q{Donut is a tool for orchestrating builds, testing and installation across multiple applications shared in a single project or repository file structure. It is language and framework agnostic, and works nicely with Circle CI.}
  spec.homepage      = "https://github.com/hhff/donut.git"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  #spec.bindir        = "exe"
  spec.executables   = ["donut"] 
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency 'thor', '~> 0.19'
end
