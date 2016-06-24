require 'rails_helper'

module Devx
  RSpec.describe Alumni, type: :model do
    let(:alumni){ FactoryGirl.create(:devx_alumni) }

    ## Title unit test
    describe 'prefix' do
      it 'should be invalid if prefix is blank' do
        alumni.prefix = nil
        expect(alumni).not_to be_valid
      end

      it 'should be valid if prefix is present' do
        expect(alumni).to be_valid
      end
    end

    describe 'first_name' do
      it 'should be invalid if first_name is blank' do
        alumni.first_name = nil
        expect(alumni).not_to be_valid
      end

      it 'should be valid if first_name is present' do
        expect(alumni).to be_valid
      end
    end

    describe 'last_name' do
      it 'should be invalid if last_name is blank' do
        alumni.last_name = nil
        expect(alumni).not_to be_valid
      end

      it 'should be valid if last_name is present' do
        expect(alumni).to be_valid
      end
    end

    describe 'gender' do
      it 'should be invalid if gender is blank' do
        alumni.gender = nil
        expect(alumni).not_to be_valid
      end

      it 'should be valid if gender is present' do
        expect(alumni).to be_valid
      end
    end


    describe 'graduation year' do
      it 'should be invalid if graduation year is blank' do
        alumni.graduation_year = nil
        expect(alumni).not_to be_valid
      end

      it 'should be valid if graduation_year is present' do
        expect(alumni).to be_valid
      end
    end

  end
end



