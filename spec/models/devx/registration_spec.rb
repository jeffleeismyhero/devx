require 'rails_helper'

module Devx
  RSpec.describe Registration, type: :model do
    let(:registration){ FactoryGirl.create(:devx_registration) }

    describe 'name' do
      it 'is invalid if blank' do
        registration.name = nil
        expect(registration).not_to be_valid
      end

      it 'is valid when name is present' do
        expect(registration).to be_valid
      end
    end
  end
end