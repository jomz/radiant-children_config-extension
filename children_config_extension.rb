# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'
require 'radiant-children_config-extension/version'
class ChildrenConfigExtension < Radiant::Extension
  version RadiantChildrenConfigExtension::VERSION
  description "Allows you to override the configuration of page parts for new children under a given page."
  url "https://github.com/jomz/radiant-children_config-extension"
  
  def activate
    Page.send :include, ChildrenConfig::PageExtensions
    Admin::PagesController.send :include, ChildrenConfig::PagesControllerExtensions
  end
end
