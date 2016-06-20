module Devx
  class ArticleSubscription < ActiveRecord::Base
    belongs_to :user

    validates :category, presence: true, uniqueness: { scope: [ :user_id ] }
    validates :user_id, presence: true
  end
end
