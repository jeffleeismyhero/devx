module Devx
  class ArticleMedium < ActiveRecord::Base
  	belongs_to :article
  	belongs_to :medium
  end
end
