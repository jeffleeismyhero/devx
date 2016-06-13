module Devx
  class Ticket < ActiveRecord::Base
    belongs_to :user
    has_many :ticket_updates

    mount_uploader :file, ImageUploader
  end
end
