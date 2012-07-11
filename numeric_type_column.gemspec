# encoding: utf-8
#LANG="en_US.UTF-8"
#LC_ALL="en_US.UTF-8"
$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "numeric_type_column/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "numeric_type_column"
  s.version     = NumericTypeColumn::VERSION
  s.authors     = ["Roberto Quintanilla Gonzalez"]
  s.email       = ["roberto.quintanilla@gmail.com"]
  s.homepage    = "http://apphouse.naranya.net"
  s.summary     = "A collection of patches to Rails ActiveRecord that supports numeric type columns."
  s.description = "A collection of patches to Rails ActiveRecord - Unsigned Integer Columns, numeric STI column, numeric Polymorphic type column - which helps with partitioning in MySQL."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "activerecord", "~> 3.2.3"

  s.add_development_dependency "rails", "~> 3.2.3"
  s.add_development_dependency "kaminari"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "mysql2"
end