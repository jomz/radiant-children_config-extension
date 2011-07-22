# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "radiant-children_config-extension/version"

Gem::Specification.new do |s|
  s.name        = "radiant-children_config-extension"
  s.version     = RadiantChildrenConfigExtension::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Your Name"]
  s.email       = ["your email"]
  s.homepage    = "http://yourwebsite.com/children_config"
  s.summary     = %q{Children Config for Radiant CMS}
  s.description = %q{Makes Radiant better by adding children_config!}
  
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
  Add this to your radiant project with:
    config.gem 'radiant-children_config-extension', :version => '~>#{RadiantChildrenConfigExtension::VERSION}'
  }
end