# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'
require 'radiant-children_config-extension/version'
class ChildrenConfigExtension < Radiant::Extension
  version RadiantChildrenConfigExtension::VERSION
  description "Adds children_config to Radiant."
  url "http://yourwebsite.com/children_config"
  
  # extension_config do |config|
  #   config.gem 'some-awesome-gem'
  #   config.after_initialize do
  #     run_something
  #   end
  # end
  
  def activate
    Page.send :include, ChildrenConfig::PageExtensions
    Admin::PagesController.send :include, ChildrenConfig::PagesControllerExtensions
  end
end
