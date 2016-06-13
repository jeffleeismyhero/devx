module Devx
  class MenuPresenter
    def self.for
      :menu
    end

    def initialize(attributes, content, additional_attributes)
      @attributes = attributes
      @content = content
    end

    def content
      @content
    end

    def attributes
      { name: menu.name,
        style: @attributes[:style],
        pages: get_pages,
        paths: get_paths }
    end


    private

    def menu
      Devx::Menu.find(@attributes[:id])
    end

    def get_pages
      pages = []

      Devx::Menu.find(3).menu_pages.ordered.each do |p|
        pages.push(Devx::Page.find(p.page_id))
      end

      return pages
    end

    def get_paths
      paths = []

      get_pages.try(:each) do |p|
        if p.slug == 'home'
          paths.push('')
        else
          paths.push(p.slug)
        end
      end

      return paths
    end
  end
end