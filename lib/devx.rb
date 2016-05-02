require "devx/engine"

Gem.loaded_specs['yourengine'].dependencies.each do |d|
 require d.name
end

module Devx
end
