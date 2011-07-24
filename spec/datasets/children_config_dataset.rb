class ChildrenConfigDataset < Dataset::Base
  uses :home_page

  def load
    create_page "Services", :slug => "services", :parent_id => page_id(:home) do
      create_page_part "children_config", :content => "---
- name: location
  filter: none
- name: description
  filter: markdown
- name: date
  filter: none"
    end
  end
  
end