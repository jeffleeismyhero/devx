module Devx
  class Extracurricular < ActiveRecord::Base
  	scope :ordered, -> { order(name: :asc) }

  	has_many :extracurricular_teams
  	has_many :people, through: :extracurricular_teams
    has_many :moderators, foreign_key: :id, class_name: 'Devx::Person'

  	validates :name, presence: true, uniqueness: true
  	mount_uploader :image, ImageUploader

    def self.per_page
      return 10
    end
  end
end
