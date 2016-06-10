module Devx
  class Medium < ActiveRecord::Base
    mount_uploader :file, ImageUploader
    #mount_uploader :file, DocumentUploader

    #validates :name, presence: true
    #validates :file, presence: true
  end
end
