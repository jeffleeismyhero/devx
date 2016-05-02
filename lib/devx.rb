require "devx/engine"

Gem.loaded_specs['devx'].dependencies.each do |d|
 require d.name
end

module Devx
end
