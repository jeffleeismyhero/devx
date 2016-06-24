require 'rails_helper'

module Devx
  RSpec.describe Calendar, type: :model do
    let(:calendar){ FactoryGirl.create(:devx_calendar) }

    describe 'name' do
      it 'should be invalid if blank' do
        calendar.name = ''
        expect(calendar).not_to be_valid
      end

      it 'should be valid if provided' do
        expect(calendar).to be_valid
      end
    end
  end
end
