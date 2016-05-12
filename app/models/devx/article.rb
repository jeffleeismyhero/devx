module Devx
  class Article < ActiveRecord::Base
    scope :published, -> { where.not(published_at: nil) }
    scope :latest, -> { order(published_at: :desc) }

    validates :title, presence: true
    validates :content, presence: true

    before_create :add_publish_date

    def add_publish_date
      unless self.published_at.present?
        self.published_at = Time.zone.now
      end
    end
  end
end
