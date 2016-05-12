module Devx
  class Page < ActiveRecord::Base
    extend FriendlyId
    friendly_id :name, use: [ :slugged, :finders ]

    belongs_to :layout

    validates :name, presence: true

    def should_generate_new_friendly_id?
      name_changed?
    end
  end
end
