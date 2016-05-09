module Devx
  class Medium < ActiveRecord::Base
    mount_uploader :file, ImageUploader
    #mount_uploader :file, DocumentUploader
  end
end
