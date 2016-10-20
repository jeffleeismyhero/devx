module Devx
  class Announcement < ActiveRecord::Base
  	validates :content, presence: true

    def self.default_scope
      order(created_at: :desc)
    end
  end
end
