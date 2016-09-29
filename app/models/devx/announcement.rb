module Devx
  class Announcement < ActiveRecord::Base
  	validates :content, presence: true
  end
end
