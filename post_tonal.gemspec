# coding: utf-8
$:.push File.expand_path("../lib", __FILE__)
require "post_tonal/version"

Gem::Specification.new do |s|
  s.name        = 'post_tonal'
  s.version     = PostTonal::VERSION
  s.platform    = Gem::Platform::RUBY
  s.author     = 'Eric Rubio'
  s.email       = 'penmanglewood@fastmail.fm'
  s.homepage    = 'https://github.com/penmanglewood/post_tonal'
  s.summary     = %q{Pitch-class set analysis library}
  s.description = %q{Ruby library for analyzing pitch-class sets according to post-tonal theory}
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/{functional,unit}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_development_dependency "shoulda", ">= 2.1.1"
  s.add_development_dependency "mocha", ">= 0.9.5"
  s.add_development_dependency "rake"
end