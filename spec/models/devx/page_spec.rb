require 'rails_helper'

module Devx
  RSpec.describe Page, type: :model do
    let(:page){ FactoryGirl.build(:devx_page) }

    ## Name unit tests
    describe 'name' do
      it 'is invalid if blank' do
        page.name = ''
        expect(page).not_to be_valid
      end
    end

    ## Content unit tests
    describe 'content' do
      it 'is invalid if blank' do
        page.content = ''
        expect(page).not_to be_valid
      end
    end

  end
end
