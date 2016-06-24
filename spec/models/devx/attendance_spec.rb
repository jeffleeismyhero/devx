require 'rails_helper'

module Devx
  RSpec.describe Attendance, type: :model do
    let(:attendance){ FactoryGirl.create(:devx_attendance) }

    ## Title unit test
    describe 'registration id' do
      it 'should be invalid if blank' do
        attendance.registration = nil
        expect(attendance).not_to be_valid
      end

      it 'should be valid if user is present' do
        #puts attendance.registration.inspect
        expect(attendance).to be_valid
      end
    end

    describe 'child id' do
      it 'should be invalid if blank' do
        attendance.child = nil
        expect(attendance).not_to be_valid
      end

      it 'should be valid if present' do
        expect(attendance).to be_valid
        #puts attendance.child.inspect
      end
    end

  end
end