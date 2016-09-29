module Devx
  class Stylesheet < ActiveRecord::Base
    extend FriendlyId
    friendly_id :name, use: [ :slugged, :finders ]

    has_many :layout_stylesheets
    has_many :layouts, through: :layout_stylesheets

    validates :name, presence: true
    validates :content, presence: true
  end
end
