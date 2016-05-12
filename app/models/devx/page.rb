module Devx
  class Page < ActiveRecord::Base
    extend FriendlyId
    friendly_id :name, use: [ :slugged, :finders ]

    has_many :menu_pages
    has_many :menus, through: :menu_pages
    belongs_to :layout

    validates :name, presence: true

    def should_generate_new_friendly_id?
      name_changed?
    end
  end
end
