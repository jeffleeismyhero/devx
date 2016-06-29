module Devx
  class Form < ActiveRecord::Base
    extend FriendlyId
    friendly_id :name, use: [ :slugged, :finders ]
    serialize :submission_content, Hash

    mount_uploader :image, ImageUploader

    belongs_to :registration
    has_many :fields

    accepts_nested_attributes_for :fields, allow_destroy: true,
      reject_if: proc{ |x| x['name'].blank? }
  end
end
