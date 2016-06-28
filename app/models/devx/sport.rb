module Devx
  class Sport < ActiveRecord::Base
  	has_many :sport_teams, dependent: :destroy
  	has_many :people, through: :sport_teams
    has_many :moderators, foreign_key: :id, class_name: 'Devx::Person'

  	validates :name, presence: true

  	accepts_nested_attributes_for :sport_teams, allow_destroy: true,
  		reject_if: proc{ |x| x['person_id'].blank? }
  end
end
