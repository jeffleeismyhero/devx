require 'rails_helper'

module Devx
  RSpec.describe ChildRegistration, type: :model do
    let(:child_registration){ FactoryGirl.create(:devx_child_registration) }

    ## Title unit test
    describe 'registration id' do
      it 'should be invalid if blank' do
        child_registration.registration = nil
        expect(child_registration).not_to be_valid
        puts child_registration.registration.inspect
      end

      it 'should be valid if user is present' do
        expect(child_registration).to be_valid
      end
    end

    describe 'child id' do
      it 'should be invalid if blank' do
        child_registration.child = nil
        expect(child_registration).not_to be_valid
        puts child_registration.child.inspect
      end

      it 'should be valid if present' do
        expect(child_registration).to be_valid
      end
    end

  end
end