module Devx
  class Article < ActiveRecord::Base
    def published_at_date
      published_at.try(:strftime, "%m/%d/%Y")
    end

    def published_at_time
      published_at.try(:strftime, "%I:%M %P")
    end

    def featured_until_date
      featured_until.try(:strftime, "%m/%d/%Y")
    end

    def featured_until_time
      featured_until.try(:strftime, "%I:%M %P")
    end

    def published_at_date=(value)
      self[:published_at] = Date.parse("#{value}") if value.present?
    end

    def published_at_time=(value)
      if value.present?
        self[:published_at] = DateTime.parse("#{self[:published_at].try(:strftime, "%m/%d/%Y")} #{value} #{Time.zone.name}")
        self[:published_at] -= 1.hour if self[:published_at].dst?
      end
    end

    def featured_until_date=(value)
      self[:featured_until] = Date.parse("#{value}") if value.present?
    end

    def featured_until_time=(value)
      if value.present?
        self[:featured_until] = DateTime.parse("#{self[:featured_until].try(:strftime, "%m/%d/%Y")} #{value} #{Time.zone.name}")
        self[:featured_until] -= 1.hour if self[:featured_until].dst?
      end
    end

    extend FriendlyId
    friendly_id :title, use: [ :slugged, :finders ]

    scope :published, -> { where.not(published_at: nil) }
    scope :latest, -> { order(published_at: :desc) }
    scope :featured, -> { where("featured_until IS NULL OR featured_until >= ?", Time.now).order(featured: :desc, featured_until: :asc, published_at: :desc) }

    has_many :article_galleries
    belongs_to :user

    validates :title, presence: true, uniqueness: { scope: :published_at }
    validates :content, presence: true
    validates :tag_list, presence: true

    before_validation :add_publish_date

    mount_uploader :image, Devx::ImageUploader
    mount_uploader :document, Devx::DocumentUploader

    accepts_nested_attributes_for :article_galleries, allow_destroy: true,
      reject_if: proc{ |x| x['file'].blank? || x['file'].nil? }

    acts_as_taggable
    acts_as_taggable_on :keywords

    def self.per_page
      return 12
    end

    def should_generate_new_friendly_id?
      title_changed?
    end

    def add_publish_date
      self.published_at ||= Time.zone.now
    end
  end
end
