require_dependency "devx/application_controller"

module Devx
  class SchedulesController < ApplicationController
    load_resource :schedule, class: 'Devx::Schedule'
    load_resource :event, class: 'Devx::Event'
    load_resource :calendar, class: 'Devx::Calendar'

    def show
      if app_settings['calendar_layout'].present?
        @layout = Devx::Layout.find(app_settings['calendar_layout'])
      end

      @page = Devx::Page.new(name: @schedule.event.name, layout: @layout)
    end
    

    private

    def determine_layout
      if app_settings['calendar_layout'].present?
        'devx/custom'
      else
        'devx/application'
      end
    end
  end
end
