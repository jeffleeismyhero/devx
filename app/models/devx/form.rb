module Devx
  class Form < ActiveRecord::Base
    extend FriendlyId
    friendly_id :name, use: [ :slugged, :finders ]

    mount_uploader :image, ImageUploader

    has_many :layouts
    has_many :fields
    has_many :form_submissions

    accepts_nested_attributes_for :fields, allow_destroy: true,
      reject_if: proc{ |x| x['name'].blank? }
  end
end
