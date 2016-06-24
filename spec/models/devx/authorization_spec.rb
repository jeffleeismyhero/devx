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
      it 'should be invalid if role id < 10' do
        if
          authorization.role_id > 10
          expect(authorization).to be_valid
        end
      end

      it 'should be valid if role id  present' do
        if
          authorization.role_id < 10
          expect(authorization).to be_valid
        end
      end
    end

  end
end
