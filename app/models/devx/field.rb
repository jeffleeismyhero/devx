module Devx
  class Field < ActiveRecord::Base
    acts_as_list

    scope :ordered, -> { order(position: :asc) }

    belongs_to :form

    before_save :convert_to_titlecase

    def convert_to_titlecase
      self.name = self.name.titleize
    end
  end
end
