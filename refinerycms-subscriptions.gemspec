# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "refinerycms-subscriptions/version"

Gem::Specification.new do |s|
  s.name        = "refinerycms-subscriptions"
  s.version     = %q{0.9.9.9} #Refinerycms::Subscriptions::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Llama Digital"]
  s.email       = ["jon@llamadigital.net"]
  s.homepage    = "llamadigital.net"
  s.summary     = %q{Subscription handling functionality for the Refinery CMS project.}
  s.description = %q{Subscription handling functionality extracted from Refinery CMS to allow you to have a contact form and manage subscriptions in the Refinery backend.}

  s.rubyforge_project = "refinerycms-subscriptions"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('filters_spam', '~> 0.2')
end

