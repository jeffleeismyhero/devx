require_dependency "devx/application_controller"

module Devx
  class AdministrationController < ApplicationController
  	load_resource :administration, class: 'Devx::Person'

  	def index
  		@administrations = Devx::Person.all
  		@q = @administrations.search(params[:q])
  		@q.sorts = 'last_name asc, first_name asc' if @q.sorts.empty?
  		@administrations = @q.result(distinct: true)

  		@departments = Devx::Person.tag_counts_on(:departments).order(name: :asc)
  	end
  end
end
