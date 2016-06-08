require "devx/engine"
require "devx/version"

Gem.loaded_specs['devx'].runtime_dependencies.each do |d|
 require d.name
end

module Devx
end
