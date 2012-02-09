# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "bone_tree/version"

Gem::Specification.new do |s|
  s.name        = "bone_tree"
  s.version     = BoneTree::VERSION
  s.authors     = ["Matt Diebolt"]
  s.email       = ["mdiebolt@gmail.com"]
  s.homepage    = "http://mdiebolt.github.com/"
  s.summary     = "A backbone filetree widget"
  s.description = "This is a filetree, written with Backbone. It is meant to be tree that will update your file nodes live and sort them when the node state is changed."

  s.rubyforge_project = "bone_tree"

  #s.add_dependency "railties"
  #s.add_dependency "thor",     "~> 0.14"

  s.add_development_dependency ["evergreen", "1.0.0"]

  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
