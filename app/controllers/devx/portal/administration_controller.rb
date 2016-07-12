require_dependency "devx/application_controller"

module Devx
  class Portal::AdministrationController < ApplicationController
    before_filter :authenticate_user!
    layout 'devx/portal'
    load_and_authorize_resource :administration, class: 'Devx::Person'

    def index
      @q = @administrations.search(params[:q])
      @q.sorts = 'last_name asc, first_name asc' if @q.sorts.empty?
      @administrations = @q.result(distinct: true)
    end

    def new
    end

    def edit
    end

    def create
      if @administration.valid? && @administration.save
        redirect_to devx.edit_portal_administration_path(@administration),
        notice: "Successfully created #{@administration.try(:full_name)}"
      else
        render :new,
        notice: 'An error occurred'
      end
    end

    def update
      if @administration.valid? && @administration.update(administration_params)
        redirect_to devx.edit_portal_administration_path(@administration),
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
                prefix = record[0].to_s.squish
                first_name = record[1].to_s.squish
                last_name = record[2].to_s.squish
                email = record[3].to_s.squish
                position = record[4].to_s.squish
                department = record[5].to_s.squish
                phone = record[6].to_s.squish
                address = record[7].to_s.squish
                city = record[8].to_s.squish
                state = record[9].to_s.squish
                zip = record[10].to_s.squish

                person = Devx::Person.new(
                  uuid: SecureRandom.uuid,
                  prefix: prefix,
                  first_name: first_name,
                  last_name: last_name,
                  email: email,
                  position: position,
                  department_list: department,
                  phone: phone,
                  address: address,
                  city: city,
                  state: state,
                  zip: zip,
                  association_list: 'Faculty',
                  active: true
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
          redirect_to devx.portal_administration_index_path,
          notice: "#{@errors} users could not be imported due to errors"
        end
      end
    end


    private

    def administration_params
      accessible = [ :uuid, :school_id, :prefix, :photo, :first_name, :last_name, :suffix, :gender, :birthdate, :address, :city, :state, :zip, :email, :phone, :mobile_number, :association_list, :active,
                    department_list: [] ]
      params.require(:person).permit(accessible)
    end
  end
end
