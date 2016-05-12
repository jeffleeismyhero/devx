module Devx
  class Menu < ActiveRecord::Base
    has_many :menu_pages
    has_many :pages, through: :menu_pages

    validates :name, presence: true

    def added?(page)
      self.menu_pages.include?(page)
    end

    def add(page)
      unless added?(page)
        self.menu_pages.create(page: Page.find(page[:id]), position: page[:position])
      end
    end
  end
end
