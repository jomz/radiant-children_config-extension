module ChildrenConfig::PagesControllerExtensions
  def self.included(base)
    base.class_eval do
      alias :original_new :new

      def new
        unless params[:page_id].blank?
          parent_page = Page.find(params[:page_id])
          child_parts = parent_page.part("children_config").try(:content)
          self.model = model_class.new_with_children_config(config, child_parts)
        else
          self.model = model_class.new_with_defaults(config)
          self.model.slug = '/'
        end
        response_for :singular
      end
    end
  end
end