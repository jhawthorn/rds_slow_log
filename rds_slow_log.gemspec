# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rds_slow_log/version"

Gem::Specification.new do |s|
  s.name        = "rds_slow_log"
  s.version     = RdsSlowLog::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["John Hawthorn"]
  s.email       = ["john.hawthorn@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Prints the MySQL slow query log from an RDS database}
  s.description = %q{Prints the MySQL slow query log from an Amazon RDS database}

  s.rubyforge_project = "rds_slow_log"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
