require "devx/engine"
require "devx/version"

Gem.loaded_specs['devx'].runtime_dependencies.each do |d|
  if d.name == 'addressable'
    require 'addressable/uri'
  else
    require d.name
  end
end

module Devx
end
