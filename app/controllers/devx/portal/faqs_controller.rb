require_dependency "devx/application_controller"

module Devx
  class Portal::FaqsController < ApplicationController
    before_filter :authenticate_user!
    load_and_authorize_resource

    layout 'portal'

    def index
        @q = @faqs.search(params[:q])
        @q.sorts = 'question ASC' if @q.sorts.empty?
        @faqs = @q.result(distinct: true).paginate(page: params[:page], per_page: 10)
    end

    def new
        @tags = Faq.tag_counts_on(:tags)
    end

    def edit
        @tags = Faq.tag_counts_on(:tags)
    end

    def create
        @tags = Faq.tag_counts_on(:tags)
        if @faq.save
            redirect_to portal_faqs_path,
            notice: 'Successfully saved FAQ'
        else
            render :new,
            notice: 'Failed to save FAQ'
        end
    end

    def update
        @tags = Faq.tag_counts_on(:tags)
        if @faq.update(faq_params)
            redirect_to portal_faqs_path,
            notice: 'Successfully saved FAQ'
        else 
            render :new,
            notice: 'Failed to save FAQ'
        end
    end

    def destroy
        if @faq.destroy
            redirect_to portal_faqs_path
        end
    end

    def faq_params
        accessible = [ :question, :answer, :tag_list ]
        params.require(:fag).permit(accessible)
    end
  end
end


