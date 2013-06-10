# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tcpproxy/version'

Gem::Specification.new do |spec|
  spec.name          = "tcpproxy"
  spec.version       = Tcpproxy::VERSION
  spec.authors       = ["James Punnett"]
  spec.email         = ["jppunnett@yahoo.com"]
  spec.description   = %q{Spies on TCP traffic between two hosts.}
  spec.summary       = %q{Spies on TCP traffic between two hosts.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency('rdoc')
  spec.add_development_dependency('aruba')
  spec.add_development_dependency('rake', '~> 0.9.2')
  spec.add_dependency('methadone', '~> 1.3.0')
end
