module Devx
  class ClassDocument < ActiveRecord::Base
  	belongs_to :classroom

  	validates :name, presence: true
  	validates :filename, presence: true

    mount_uploader :filename, Devx::DocumentUploader
  end
end
