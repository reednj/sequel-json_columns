# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sequel/plugins/json_columns'

Gem::Specification.new do |spec|
  spec.name          = "sequel-json_columns"
  spec.version       = Sequel::Plugins::JsonColumns::VERSION
  spec.authors       = ["Nathan Reed"]
  spec.email         = ["reednj@gmail.com"]

  spec.summary       = "Add json fields to sequel, even if not supported by the engine"
  spec.homepage      = "https://github.com/reednj/sequel-json_columns"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "mysql2"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "test-unit"

  spec.add_dependency "sequel"
  
end
