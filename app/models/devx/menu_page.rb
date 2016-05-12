module Devx
  class MenuPage < ActiveRecord::Base
    belongs_to :menu
    belongs_to :page

    validates :menu_id, presence: true
    validates :page, presence: true, uniqueness: { scope: [ :menu_id ] }
  end
end
