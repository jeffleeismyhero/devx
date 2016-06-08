module Devx
  class Javascript < ActiveRecord::Base
  	extend FriendlyId
  	friendly_id :name, use: [ :slugged, :finders ]

  	has_many :layout_javascript
  	has_many :layouts, through: :layout_javascript

  	validates :name, presence: true
  	validates :content, presence: true
  end
end
