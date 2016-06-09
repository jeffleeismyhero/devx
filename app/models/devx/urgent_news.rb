module Devx
  class UrgentNews < ActiveRecord::Base
  	scope :latest, -> { order('start_time DESC').limit(1) }

  	validates :title, presence: true
  	validates :message, presence: true
  end
end