module Devx
  class SportTeam < ActiveRecord::Base
  	belongs_to :sport
  	belongs_to :person

  	validates :sport, presence: true, uniqueness: { scope: [ :person_id ] }
  	validates :person_id, presence: true
  end
end
