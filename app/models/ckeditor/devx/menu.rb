module Devx
  class Menu < ActiveRecord::Base
    has_many :menu_pages, dependent: :destroy
    has_many :pages, through: :menu_pages

    validates :name, presence: true

    def added?(page)
      self.menu_pages.include?(page)
    end

    def add(page)
      unless added?(page)
        #self.menu_pages.create(page: page, position: page[:position])
        if page.children.any?
          page.children.try(:each) do |child|
            "test"
            #menu_pages.create(page: page, position: page[:position], parent_id: page.parent_id)
          end
        end

        #return true
      end
    end
  end
end
