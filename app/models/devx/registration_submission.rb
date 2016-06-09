module Devx
  class RegistrationSubmission < ActiveRecord::Base
    belongs_to :registration
    serialize :submission_content, Hash
  end
end
