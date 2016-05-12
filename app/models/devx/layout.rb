module Devx
  class Layout < ActiveRecord::Base
    has_many :pages
    has_many :layout_stylesheets
    has_many :stylesheets, through: :layout_stylesheets

    validates :name, presence: true
    validates :content, presence: true
  end
end
