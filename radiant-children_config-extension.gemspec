# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "radiant-children_config-extension/version"

Gem::Specification.new do |s|
  s.name        = "radiant-children_config-extension"
  s.version     = RadiantChildrenConfigExtension::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Benny Degezelle"]
  s.email       = ["rubygems@monkeypatch.be"]
  s.homepage    = "https://github.com/jomz/radiant-children_config-extension"
  s.summary     = %q{Children Config extension for Radiant CMS}
  s.description = %q{Allows you to define new defaults on a page per page basis.}
  
  ignores = if File.exist?('.gitignore')
    File.read('.gitignore').split("\n").inject([]) {|a,p| a + Dir[p] }
  else
    []
  end
  s.files         = Dir['**/*'] - ignores
  s.test_files    = Dir['test/**/*','spec/**/*','features/**/*'] - ignores
  # s.executables   = Dir['bin/*'] - ignores
  s.require_paths = ["lib"]
  
  s.post_install_message = %{
  Add this to your radiant project by putting this line in your Gemfile:
    gem "radiant-children_config-extension", "~> #{RadiantChildrenConfigExtension::VERSION}"
  }
end