require_relative 'html_tag'

module RoQua
  module Helpers
    # NANOC Helper for the Navigation related stuff.
    #
    # This module contains functions for generating navigation menus for your
    # pages, like navigation menu, breadcrumbs or a table of content for a given Item
    #
    # @author Anouar ADLANI <anouar@adlani.com>
    module Sidebar
      include Nanoc::Helpers::LinkTo
      include Nanoc::Helpers::Breadcrumbs
      include RoQua::Helpers::HtmlTag

      # Generate a Table of Content for a given item. The toc will be generated
      # form the item content. The parsing is done with Nokogiri through XPath.
      #
      # @param  [Nanoc::ItemRep]  item_rep - the representation of desired item
      # @param  [Hash]    options - The Optional parameters
      # @option options (see #render_menu)
      # @option options [String] :path ('div[@class="section"]') Generic XPath for the sections
      #
      # @return [String] The output ready to be displayed by the caller
      #
      # @see http://nokogiri.org/
      def toc_for(item_rep, options={})
        require 'nokogiri'
        item_rep = item_rep.rep_named(:default) if item_rep.is_a? Nanoc::Item

        options[:path]             ||= 'div[@class="section"]'

        # Retreive the parsed content and init nokogiri
        compiled_content = item_rep.instance_eval { @content[:pre] }
        doc = Nokogiri::HTML(compiled_content)
        doc_root = doc.xpath('/html/body').first
        return [] if doc_root.nil?

        # Find all sections, and render them
        find_toc_sections(doc_root, options[:path])
      end

      # Render a Hash to a HTML List by default
      #
      # Hash structure should be construct like this:
      #
      #   Link: is an hash with the following key
      #         - :title       => The content of the link
      #         - :link        => The link
      #         - :subsections => nil or an Array of Links
      #
      #   [{:title => 'Title', :link => 'http://example.com', :subsections =>  [{}, {}, ...]},{...}]
      #
      # Results to an output like the following (by default):
      #   <ul>
      #     <li>
      #       <a href="http://example.com">Title</a>
      #       <ul>
      #         <li><a href="">Title</a></li>
      #       </ul>
      #     </li>
      #     <li><a href="http://example.com">Title</a></li>
      #     <li><a href="http://example.com">Title</a></li>
      #   </ul>
      #
      # @param  [Array]  items - The array of links that need to be rendered
      # @param  [Hash]    options - The Optional parameters
      # @option options [Interger] :depth (3) maximum depth of the rendered menu
      #
      # @return [String] The output ready to be displayed by the caller
      def render_menu(items, options={})
        options[:depth]            ||= 3
        # Decrease the depth level
        options[:depth] -= 1

        rendered_menu = items.map do |item|
          # Render only if there is depth left
          if options[:depth].to_i  > 0 && item[:subsections]
            subitems = render_menu(item[:subsections], options)
            options[:depth] += 1 # Increase the depth level after the call of navigation_for

            menu_item = content_tag('h3',
              content_tag('a', '', href: '#', class: 'js-expand-btn collapsed arrow-btn') +
              link_to_unless_current(item[:title], item[:link]))

            content_tag('li', menu_item + subitems, class: 'js-topic')
          else
            menu_item = link_to_unless_current(item[:title], item[:link])
            content_tag('li', menu_item)
          end


        end.join()

        content_tag('ul', rendered_menu) unless rendered_menu.strip.empty?
      end

    private

      # Recursive method that extract from an XPath pattern the document structure
      # and return the "permalinks" to each sections in an Array of Hash that
      # could be used by the rendering method. The structure is deducted by the
      # H1-6 header within the html element defined by the XPATH
      def find_toc_sections(section, section_xpath, title_level=1)
        return {} unless section.xpath(section_xpath)

        # For each section found call the find_toc_sections on it with an
        # increased header level (ex: h1 => h2) and then generate the hash res
        sections = section.xpath(section_xpath).map do |subsection|
          header = subsection.css("h1, h2, h3, h4, h5, h6").first
          sub_id = subsection['id']
          sub_title = header ? header.inner_html : 'untitled'
          subsections = {}

          if subsection.xpath("#{section_xpath}") && title_level <= 6
            subsections = find_toc_sections(subsection, "#{section_xpath}", title_level+1)
          end
          { :title => sub_title, :link => '#' + sub_id, :subsections =>  subsections }
        end
      end

      # Recursive method that extract from an XPath pattern the document structure
      # and return the "permalinks" in a Array of Hash that could be used by the
      # rendering method
      def find_item_tree(root, options={})
        return nil unless root.children

        # filter the elements to contain only the kind requested
        children = options[:kind] ? root.children.select { |item| item[:kind] == options[:kind] } : root.children

        # For each child call the find_item_tree on it and then generate the hash
        sections = children.map do |child|
          subsections = find_item_tree(child)

          { :title        => (child[:title] || child.identifier),
            :link         => relative_path_to(child),
            :subsections  => subsections }
        end
      end

      def find_breadcrumbs_trail(root)
        trail = ["/"]
        root.split('/').each { |s| trail << trail.last + "#{s}/" unless s.empty? }
        trail.map do |child_identifier|
          child = @items[child_identifier]
          { :title        => (child[:short_title] || child[:title] || child.identifier),
            :link         => relative_path_to(child),
            :subsections  => nil } if child
        end.compact
      end
    end
  end
end
