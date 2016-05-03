module Devx
  class Branding < ActiveRecord::Base
    mount_uploader :logo, ImageUploader
  end
end
