module Devx
  class Article < ActiveRecord::Base
    scope :latest, -> { order(created_at: :desc) }

    validates :title, presence: true
    validates :content, presence: true
  end
end
