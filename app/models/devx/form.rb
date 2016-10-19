module Devx
  class Form < ActiveRecord::Base
    extend FriendlyId
    friendly_id :name, use: [ :slugged, :finders ]

    mount_uploader :image, ImageUploader

    belongs_to :layout
    has_many :fields
    has_many :form_submissions

    # before_save :update_fields

    accepts_nested_attributes_for :fields, allow_destroy: true,
      reject_if: proc{ |x| x['name'].blank? }

    def should_generate_new_friendly_id?
      name_changed?
    end

    # def update_fields
    #   self.fields.collect(&:convert_to_titlecase)
    # end
  end
end
