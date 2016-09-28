module Devx
  class Medium < ActiveRecord::Base
  	has_many :article_media
  	has_many :articles, through: :article_media
    mount_uploader :file, ImageUploader
    #mount_uploader :file, DocumentUploader

    #validates :name, presence: true
    #validates :file, presence: true
  end
end
