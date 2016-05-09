module Devx
  class Branding < ActiveRecord::Base
    mount_uploader :logo, Devx::ImageUploader
  end
end
