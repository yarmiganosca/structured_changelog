# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'structured_changelog/version'

Gem::Specification.new do |spec|
  spec.name          = "structured_changelog"
  spec.version       = StructuredChangelog::VERSION
  spec.authors       = ["Chris Hoffman"]
  spec.email         = ["yarmiganosca@gmail.com"]

  spec.summary       = %q{A useful changelog, for a change.}
  spec.description   = "Version your gem through your changelog, not a VERSION constant."
  spec.homepage      = "https://www.github.com/yarmiganosca/structured_changelog"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "fantaskspec"

  spec.add_dependency 'git'
  spec.add_dependency 'rake'
end
