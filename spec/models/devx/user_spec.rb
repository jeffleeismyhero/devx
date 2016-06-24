require 'rails_helper'

module Devx
  RSpec.describe User, type: :model do
    let(:user){ FactoryGirl.create(:devx_user) }

    ## E-mail unit tests
    describe 'email' do
      it 'is invalid if blank' do
        user.email = ''
        expect(user).not_to be_valid
      end

      it 'is valid when required fields are input' do
        expect(user).to be_valid
      end
    end

    ## Password unit tests
    describe 'password' do
      it 'is invalid if blank' do
        user.password = ''
        expect(user).not_to be_valid
      end
    end

    describe 'children' do
      it 'should allow multiple children' do
        expect(user).to respond_to(:children)
      end
    end

    ## Role unit tests
    describe 'roles' do
      it 'should allow multiple roles' do
        expect(user).to respond_to(:roles)
      end
    end

  end
end
