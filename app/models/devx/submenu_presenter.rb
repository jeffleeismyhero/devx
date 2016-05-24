module Devx
  class SubmenuPresenter
    def self.for
      :submenu
    end

    def initialize(attributes, content, additional_attributes)
      @attributes = attributes
      @content = content
    end

    def content
      @content
    end

    def attributes
      { page: @attributes[:page_id],
        pages: get_pages,
        paths: get_paths }
    end


    private

    def subpages
      Devx::Page.all.where(parent: @attributes[:page_id])
    end

    def get_pages
      pages = []

      subpages.ordered.each do |p|
        pages.push()
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