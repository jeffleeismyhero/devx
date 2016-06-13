module Devx
  class TicketUpdate < ActiveRecord::Base
    belongs_to :user
    belongs_to :ticket

    mount_uploader :file, ImageUploader
  end
end
