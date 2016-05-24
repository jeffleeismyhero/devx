module Devx
  class Page < ActiveRecord::Base
    extend FriendlyId
    friendly_id :name, use: [ :slugged, :finders ]

    scope :ordered, -> { order(position: :asc) }

    has_one :page, foreign_key: 'parent'
    has_many :menu_pages
    has_many :menus, through: :menu_pages
    belongs_to :layout

    validates :name, presence: true
    validates :content, presence: true

    mount_uploader :image, Devx::ImageUploader

    def should_generate_new_friendly_id?
      name_changed?
    end
  end
end
