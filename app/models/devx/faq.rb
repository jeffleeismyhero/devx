module Devx
  class Faq < ActiveRecord::Base
  	acts_as_taggable

  	validates :question, presence: true
  	validates :answer, presence: true
  	validates :tag_list, presence: true
  end
end

