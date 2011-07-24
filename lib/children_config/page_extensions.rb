module ChildrenConfig::PageExtensions
  def self.included(base)
    base.class_eval do
      after_save :create_children
      
      def self.new_with_children_config(config = Radiant::Config, parts = String)
        begin
          unless parts.empty?
            config = YAML::load(parts)
            if config.is_a?(Array) && config.select{|c| c.has_key? "parts"}.size > 0
              page = new
              options = {}
              config.select{|c| c.has_key? "parts"}.first["parts"].each do |part|
                options[:name] = part['name']
                options[:content] = part['content']
                default_filter = part['filter'].to_s.camelize
                options[:filter_id] = ["SmartyPants", "Markdown", "Textile", "WymEditor", "CKEditor"].include?(default_filter) ? "#{default_filter}" : ""
                # Consider page part type if page_parts extension is present
                if PagePart.column_names.include? "page_part_type"
                  options[:page_part_type] = part['page_part_type'].to_s.camelize
                end
                page.parts << PagePart.new(options)
              end
              page
            end
          else
            new_with_defaults(config)
          end
        rescue
          new_with_defaults(config)
        end
      end
      
      
    end
  end
  
  def create_children
    if updated_at == created_at and parent and children_config = parent.part(:children_config).try(:content)
      config = YAML::load(children_config)
      if config.is_a?(Array) && config.select{|c| c.has_key? "children"}.size > 0
        config.select{|c| c.has_key? "children"}.first["children"].each do |child|
          options = {}
          options[:parent_id] = self.id
          options[:status_id] = Status[child['status'].downcase.to_sym].id
          options[:class_name] = child['class_name']
          page = Page.new(options)
          page.breadcrumb = page.title = child['title']
          page.slug = child['title'].slugify
          if child.has_key? "parts"
            child["parts"].each do |part|
              part["page_part_type"] = part["page_part_type"].to_s.camelize
              part["filter_id"] = ["SmartyPants", "Markdown", "Textile", "WymEditor", "CKEditor"].include?(part["filter"]) ? "#{default_filter}" : ""
              page.parts.build(part)
            end
          else
            config = Radiant::Config
            default_parts = config['defaults.page.parts'].to_s.strip.split(/\s*,\s*/)
            default_parts.map do |name|
              page.parts << PagePart.new(:name => name, :filter_id => config['defaults.page.filter'])
            end
            
          end
          raise page.errors.full_messages.join ", " unless page.valid?
          page.save
        end
      
      end
    end
  end
end