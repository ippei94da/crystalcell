# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "crystalcell"
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["ippei94da"]
  s.date = "2015-02-05"
  s.description = "This gem provides Cell, LatticeAxes, Atom classes, and so on.\n    And this provides simple treatment of a periodic boundary condition.\n  "
  s.email = "ippei94da@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "CHANGES",
    "Gemfile",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "crystalcell.gemspec",
    "lib/crystalcell.rb",
    "lib/crystalcell/atom.rb",
    "lib/crystalcell/cell.rb",
    "lib/crystalcell/element.rb",
    "lib/crystalcell/latticeaxes.rb",
    "lib/crystalcell/periodiccell.rb",
    "test/cif/ZrO2-25C.cif",
    "test/helper.rb",
    "test/test_atom.rb",
    "test/test_cell.rb",
    "test/test_element.rb",
    "test/test_latticeaxes.rb",
    "test/test_periodiccell.rb"
  ]
  s.homepage = "http://github.com/ippei94da/crystalcell"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "Classes around a cell in crystallography"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rdoc>, ["~> 4.1.1"])
      s.add_development_dependency(%q<bundler>, ["~> 1.7.2"])
      s.add_development_dependency(%q<jeweler>, ["~> 2.0.1"])
      s.add_development_dependency(%q<simplecov>, [">= 0.9.0"])
      s.add_development_dependency(%q<malge>, [">= 0.0.8"])
      s.add_development_dependency(%q<mageo>, [">= 0.0.3"])
      s.add_development_dependency(%q<maset>, [">= 0.0.0"])
      s.add_development_dependency(%q<builtinextension>, [">= 0.1.2"])
    else
      s.add_dependency(%q<rdoc>, ["~> 4.1.1"])
      s.add_dependency(%q<bundler>, ["~> 1.7.2"])
      s.add_dependency(%q<jeweler>, ["~> 2.0.1"])
      s.add_dependency(%q<simplecov>, [">= 0.9.0"])
      s.add_dependency(%q<malge>, [">= 0.0.8"])
      s.add_dependency(%q<mageo>, [">= 0.0.3"])
      s.add_dependency(%q<maset>, [">= 0.0.0"])
      s.add_dependency(%q<builtinextension>, [">= 0.1.2"])
    end
  else
    s.add_dependency(%q<rdoc>, ["~> 4.1.1"])
    s.add_dependency(%q<bundler>, ["~> 1.7.2"])
    s.add_dependency(%q<jeweler>, ["~> 2.0.1"])
    s.add_dependency(%q<simplecov>, [">= 0.9.0"])
    s.add_dependency(%q<malge>, [">= 0.0.8"])
    s.add_dependency(%q<mageo>, [">= 0.0.3"])
    s.add_dependency(%q<maset>, [">= 0.0.0"])
    s.add_dependency(%q<builtinextension>, [">= 0.1.2"])
  end
end

