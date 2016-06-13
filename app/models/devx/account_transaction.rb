module Devx
  class AccountTransaction < ActiveRecord::Base
    belongs_to :user
  end
end
