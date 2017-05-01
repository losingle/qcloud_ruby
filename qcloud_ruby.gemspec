# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'qcloud_ruby/version'

Gem::Specification.new do |spec|
  spec.name          = "qcloud_ruby"
  spec.version       = QcloudRuby::VERSION
  spec.authors       = ["aiasfina"]
  spec.email         = ["aiasfina@gmail.com"]

  spec.summary       = %q{An unofficial Tencent Qcloud API SDK for Ruby.}
  spec.description   = %q{An unofficial Tencent Qcloud API SDK for Ruby.}
  spec.homepage      = "https://github.com/aiasfina/qcloud_ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
