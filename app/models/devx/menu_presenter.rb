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
        pages: get_pages,
        paths: get_paths }
    end


    private

    def menu
      Devx::Menu.find(@attributes[:id])
    end

    def get_pages
      pages = []

      menu.menu_pages.ordered.each do |p|
        pages.push(Devx::Page.find(p.id))
      end

      return pages
    end

    def get_paths
      paths = []

      get_pages.try(:each) do |p|
        paths.push(p.slug)
      end

      return paths
    end
  end
end