require_dependency "devx/application_controller"

module Devx
  class Portal::AdministrationController < ApplicationController
    before_filter :authenticate_user!
    layout 'devx/portal'
    load_and_authorize_resource :administration, class: 'Devx::Person'

    def index
      @q = @administrations.search(params[:q])
      @q.sorts = 'name asc' if @q.sorts.empty?
      @administrations = @q.result(distinct: true)
    end

    def new
    end

    def edit
    end

    def create
      if @administration.valid? && @administration.save
        redirect_to devx.portal_administration_index_path,
        notice: "Successfully created #{@administration.try(:full_name)}"
      else
        render :new,
        notice: 'An error occurred'
      end
    end

    def update
      if @administration.valid? && @administration.update(administration_params)
        redirect_to devx.portal_administration_index_path,
        notice: "Successfully updated #{@administration.try(:full_name)}"
      else
        render :edit,
        notice: 'An error occurred'
      end
    end

    def destroy
      if @administration.destroy
        redirect_to devx.portal_administration_index_path,
        notice: "Successfully deleted #{@administration.try(:full_name)}"
      else
        render :index,
        notice: 'An error occurred'
      end
    end

    def import
      require 'csv'

      @import = Devx::Import.new(params[:import])
      @errors = 0

      if request.post?
        if @import.valid?

          if records = CSV.read(@import.file.path, headers: true)
            logfile = File.open("#{Rails.root}/log/import.log", "a")
            logfile.sync = true
            logger = Logger.new(logfile)

            records.each_with_index do |record, index|
              if params[:import_type] == 'Faculty'
                last_name = record[0].to_s.squish
                first_name = record[1].to_s.squish
                prefix = record[2].to_s.squish
                position = record[3].to_s.squish
                email = record[4].to_s.squish
                department = record[5].to_s.squish

                person = Devx::Person.new(
                  prefix: prefix,
                  first_name: first_name,
                  last_name: last_name,
                  email: email,
                  position: position,
                  department_list: department,
                  association_list: 'Faculty'
                )

                if person.valid?
                  logger.info "Expecting object to be valid #{person.inspect}"
                  person.save
                else
                  logger.warn "Failed to import object: #{person.inspect}"
                  person.errors.full_messages.try(:each) do |error|
                    logger.warn "#{error}"
                  end
                  @errors += 1
                end
              end
            end


          end
        end
      end
    end


    private

    def administration_params
      accessible = [ :uuid, :prefix, :first_name, :last_name, :suffix, :gender, :birthdate, :address, :city, :state, :zip, :email, :phone, :mobile_number, :association_list, :active ]
      params.require(:person).permit(accessible)
    end
  end
end
