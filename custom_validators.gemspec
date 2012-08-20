# -*- encoding: utf-8 -*-
require File.expand_path('../lib/custom_validators/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Vlad Verestiuc Ovidiu"]
  gem.email         = ["vlad.verestiuc@me.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "custom_validators"
  gem.require_paths = ["lib"]
  gem.version       = CustomValidators::VERSION

  gem.add_dependency "addressable"
  gem.add_dependency "activemodel"

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "guard-rspec"
  # gem.add_development_dependency "ruby-debug"

end
