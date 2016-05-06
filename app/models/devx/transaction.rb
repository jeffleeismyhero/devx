module Devx
  class Transaction < ActiveRecord::Base
    belongs_to :order
  end
end
