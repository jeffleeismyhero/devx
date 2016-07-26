module Devx
  class ClassDocument < ActiveRecord::Base
  	belongs_to :classroom

  	validates :name, presence: true
  	validates :filename, presence: true
  end
end
