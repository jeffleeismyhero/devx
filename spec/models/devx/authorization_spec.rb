require 'rails_helper'

module Devx
  RSpec.describe Authorization, type: :model do
    let(:authorization){ FactoryGirl.create(:devx_authorization) }

    ## Title unit test
    describe 'user' do
      it 'should be invalid if user is blank' do
        authorization.user = nil
        expect(authorization).not_to be_valid
      end

      it 'should be valid if user is present' do
        expect(authorization).to be_valid
      end
    end

    describe 'role id' do
      it 'should be invalid if role id not present' do
        authorization.role = nil
        expect(authorization).not_to be_valid
      end

      it 'should be valid if role id is present' do
        expect(authorization).to be_valid
      end
    end

  end
end
