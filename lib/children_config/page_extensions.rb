module ChildrenConfig::PageExtensions
  def self.included(base)
    base.class_eval do
      
      def self.new_with_page_parts(config = Radiant::Config, parts = String)
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
end