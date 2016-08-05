require "devx/engine"
require "devx/version"

Gem.loaded_specs['devx'].runtime_dependencies.each do |d|
  if d.name == 'addressable'
    require 'addressable/uri'
  elsif d.name == 'yui-compressor'
    require 'yui/compressor'
  elsif d.name == 'google-api-client'
    require 'google/apis/calendar_v3'
    require 'googleauth'
    require 'googleauth/stores/file_token_store'
  else
    require d.name
  end
end

module Devx
end
