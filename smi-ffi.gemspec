# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "smi/version"

Gem::Specification.new do |s|
  s.name        = "smi-ffi"
  s.version     = Smi::Ffi::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ron McClain"]
  s.email       = ["mixtli@github.com"]
  s.homepage    = ""
  s.summary     = %q{Wrapper around libsmi}
  s.description = %q{Provides methods to translate SMI names to OIDs.}

  s.rubyforge_project = "smi-ffi"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_dependency('nice-ffi')
end
