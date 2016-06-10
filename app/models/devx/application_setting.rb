module Devx
  class ApplicationSetting < ActiveRecord::Base
    serialize :settings, Hash
  end
end
