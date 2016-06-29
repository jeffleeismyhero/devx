module Devx
  class FormSubmission < ActiveRecord::Base
  	belongs_to :form
  	serialize :submission_content

  	validates :submission_content, presence: true
  end
end
