# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'big_xml/version'

Gem::Specification.new do |gem|
  gem.name          = "big_xml"
  gem.version       = BigXML::VERSION
  gem.authors       = ["Christian Hellsten"]
  gem.email         = ["christian@aktagon.com"]
  gem.description   = %q{A Ruby gem and tool for parsing big XML files efficiently.}
  gem.summary       = %q{A Ruby gem and tool for parsing big XML files efficiently.}
  gem.homepage      = "http://github.com/christianhellsten/big-xml"

  gem.add_runtime_dependency("nokogiri")

  gem.add_development_dependency("pry")
  #gem.add_development_dependency("awesome_print")

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
