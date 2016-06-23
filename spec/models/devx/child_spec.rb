require 'rails_helper'

module Devx
  RSpec.describe Child, type: :model do
    let(:child){ FactoryGirl.create(:devx_child) }

    describe 'first name' do
      it 'is invalid if blank' do
        child.first_name = nil
        expect(child).not_to be_valid
      end

      it 'is valid when first name is present' do
        expect(child).to be_valid
      end
    end

    describe 'last name' do
      it 'is invalid if blank' do
        child.last_name = nil
        expect(child).not_to be_valid
      end

      it 'is valid when last name is present' do
        expect(child).to be_valid
      end
    end
  end
end