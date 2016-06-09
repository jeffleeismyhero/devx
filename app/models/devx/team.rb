module Devx
  class Team < ActiveRecord::Base
  	belongs_to :sport
  	belongs_to :user

  	acts_as_taggable

  	validates :sport_id, presence: true
  	validates :user, presence: true
  end
end
