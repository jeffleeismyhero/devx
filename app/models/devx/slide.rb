module Devx
  class Slide < ActiveRecord::Base
    scope :active, -> { where(active: true) }

    acts_as_list

    belongs_to :slideshow

    validates :image, presence: true, if: :new_record?

    mount_uploader :image, Devx::ImageUploader
  end
end
