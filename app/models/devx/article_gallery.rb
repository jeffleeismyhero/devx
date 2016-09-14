module Devx
  class ArticleGallery < ActiveRecord::Base
    belongs_to :article

    mount_uploader :file, ImageUploader
  end
end
