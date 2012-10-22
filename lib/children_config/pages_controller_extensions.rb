module ChildrenConfig::PagesControllerExtensions
  def self.included(base)
    base.class_eval do
      alias_method_chain :new, :children_config
      
    end
  end
  
  def new_with_children_config
    unless params[:page_id].blank?
      parent_page = Page.find(params[:page_id])
      yaml_config = parent_page.part("children_config").try(:content)
      @page = self.model = model_class.new_with_children_config(config, yaml_config)
      assign_page_attributes
      response_for :new
    else
      new_without_children_config
    end
    
  end
end
