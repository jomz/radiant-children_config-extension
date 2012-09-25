# Children Config

Allows you to define new default page parts on every page.
Based on the [default\_page\_parts extension](https://github.com/santry/radiant-default-page-parts-extension), originally created by Sean Santry.

## How to use

Let's say you want all pages under "Events" to have the page parts "location", "description" and "date" by default. 
Simply add a "children_config" page part to the "Events" page. In the content of that page part, put: 

    ---
    - parts:
      - name: location
        filter: none
      - name: description
        filter: markdown
      - name: date
        filter: none

If you are using the [page_parts extension](https://github.com/digitalpulp/radiant-page_parts-extension), you can also pass the desired page part type like so:

    ---
    - parts:
      - name: location
        filter: none
        page_part_type: string_page_part
      - name: description
        filter: markdown
      - name: date
        filter: none
        page_part_type: date_page_part

You can also specify a new default class:

    ---
    - class_name: archive_page
    - parts:
      ...
      
Or default fields:

    ---
    - parts:
      ...
    - fields:
      - name: foo
        content: bar

Another feature is to automatically create children for every new event page:

    ---
    - parts:
      - name: location
        filter: none
        page_part_type: string_page_part
      - name: description
        filter: markdown
      - name: date
        filter: none
        page_part_type: date_page_part
    - children:
      - title: News
        status: published
        parts:
          - name: body
            content: "<r:children:each><div><r:content /></div></r:children:each>"
            
It is possible to pass YAML to the content of a generated child, for example to set up a children\_config part again, you can use the '+' indicator for that. For example:

    ---
    - children:
      - title: News
        status: published
        parts:
          - name: body
            content: "<r:children:each><div><r:content /></div></r:children:each>"
          - name: children_config
            content: |+
              ---
              - parts:
                - name: body
                  ...
                  
