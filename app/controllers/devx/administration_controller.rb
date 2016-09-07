require_dependency "devx/application_controller"

module Devx
  class AdministrationController < ApplicationController
  	load_resource :administration, class: 'Devx::Person'
  	layout :determine_layout

  	def index
      if app_settings['staff_directory'].present?
        @layout = Devx::Layout.find(app_settings['staff_directory'])
      end

      @page = Devx::Page.new(name: 'Staff Directory', layout: @layout)

  		@administrations = Devx::Person.faculty.active
  		@q = @administrations.search(params[:q])
  		@q.sorts = 'last_name asc, first_name asc' if @q.sorts.empty?
  		@administrations = @q.result(distinct: true)

  		@departments = @administrations.tag_counts_on(:departments).order(name: :asc)
  	end

    def determine_layout
      if app_settings['staff_directory'].present?
        'devx/custom'
      else
        'devx/application'
      end
    end
  end
end
