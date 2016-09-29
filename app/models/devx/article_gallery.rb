module Devx
  class ArticleGallery < ActiveRecord::Base
    acts_as_list
    
    belongs_to :article

    validates :file, presence: true

    mount_uploader :file, ImageUploader
  end
end
