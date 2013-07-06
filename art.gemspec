# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'art/version'

Gem::Specification.new do |gem|
  gem.name          = "art"
  gem.version       = Art::VERSION
  gem.authors       = ["jayteesf"]
  gem.email         = ["jayteesf"]
  gem.description   = %q{all rights reserved; for internal use only}
  gem.summary       = %q{Logo-esq utility}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  # specify any dependencies here; for example:

  gem.add_development_dependency "rspec", ">= 2.13.0"
end
