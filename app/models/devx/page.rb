module Devx
  class Page < ActiveRecord::Base
    extend FriendlyId
    friendly_id :name, use: [ :slugged, :finders ]

    scope :ordered, -> { order(position: :asc) }
    scope :active, -> { where(active: true) }

    has_one :page, foreign_key: 'parent'
    has_many :menu_pages
    has_many :menus, through: :menu_pages
    belongs_to :layout

    validates :name, presence: true
    validates :content, presence: true

    mount_uploader :image, Devx::ImageUploader

    before_save :check_if_home

    def self.home_page
        find_by(is_home: true)
    end

    def should_generate_new_friendly_id?
      name_changed?
    end

    def check_if_home
        if self.is_home == true || self.is_home == 'true'
            if !Devx::Page.home_page.nil? && Devx::Page.home_page != self
                Devx::Page.home_page.update_columns(is_home: false)
            end
        else
            if Devx::Page.home_page == self
                self.is_home = true
            end
        end


        if self.is_home == true
            self.active = true
        end

    end
  end
end
