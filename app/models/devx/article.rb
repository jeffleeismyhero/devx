module Devx
  class Article < ActiveRecord::Base
    extend FriendlyId
    friendly_id :title, use: [ :slugged, :finders ]

    scope :published, -> { where.not(published_at: nil) }
    scope :latest, -> { order(published_at: :desc) }

    has_many :article_media
    has_many :media, through: :article_media
    belongs_to :user

    validates :title, presence: true, uniqueness: { scope: :published_at }
    validates :content, presence: true
    validates :tag_list, presence: true

    before_create :add_publish_date

    mount_uploader :image, Devx::ImageUploader
    mount_uploader :document, Devx::DocumentUploader

    acts_as_taggable
    acts_as_taggable_on :keywords

    def self.per_page
      return 12
    end

    def should_generate_new_friendly_id?
      title_changed?
    end

    def add_publish_date
      unless self.published_at.present?
        self.published_at = Time.zone.now
      end
    end
  end
end
