module Devx
  class Branding < ActiveRecord::Base
    mount_uploader :logo, Devx::ImageUploader
    mount_uploader :alternate_logo, Devx::ImageUploader
    mount_uploader :favicon, Devx::ImageUploader
  end
end
