module Devx
  class Import
    include ActiveModel::Model

    attr_accessor :file
    validates :file, presence: true
  end
end