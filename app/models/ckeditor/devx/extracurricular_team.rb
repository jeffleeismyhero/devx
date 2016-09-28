module Devx
  class ExtracurricularTeam < ActiveRecord::Base
  	belongs_to :extracurricular
  	belongs_to :person
  end
end
