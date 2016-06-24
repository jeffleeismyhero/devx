require 'rails_helper'

module Devx
  RSpec.describe Role, type: :model do
    let(:role){ FactoryGirl.create(:devx_role) }

    describe 'name' do
      it 'is invalid if blank' do
        role.name = nil
        expect(role).not_to be_valid
      end

      it 'is valid when name is present' do
        expect(role).to be_valid
      end
    end
  end
end