module Devx
  class Field < ActiveRecord::Base
    acts_as_list
    
    belongs_to :form
  end
end
