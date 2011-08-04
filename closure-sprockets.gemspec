# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "closure-sprockets/version"

Gem::Specification.new do |s|
  s.name        = "closure-sprockets"
  s.version     = Closure::Sprockets::VERSION
  s.authors     = ["Ilya Grigorik"]
  s.email       = ["ilya@igvita.com"]
  s.homepage    = "https://github.com/igrigorik/closure-sprockets"
  s.summary     = "Sprockets processor for Google's Closure tools"
  s.description = s.summary

  s.rubyforge_project = "closure-sprockets"
  s.add_dependency "tilt"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
