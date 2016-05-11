module Devx
  class LayoutStylesheet < ActiveRecord::Base
    belongs_to :layout
    belongs_to :stylesheet
  end
end
