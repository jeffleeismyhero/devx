module Devx
  class Page < ActiveRecord::Base
    extend FriendlyId
    friendly_id :name, use: [ :slugged, :finders ]

    def should_generate_new_friendly_id?
      name_changed?
    end
  end
end
