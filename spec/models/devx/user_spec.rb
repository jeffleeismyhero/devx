require 'rails_helper'

module Devx
  RSpec.describe User, type: :model do
    let(:user){ FactoryGirl.build(:devx_user) }

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

    # describe 'roles' do
    #   it 'should allow multiple roles' do
    #     skip
    #     expect(user).to respond_to(:email)
    #   end
    # end

  end
end
