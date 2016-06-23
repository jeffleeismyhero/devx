require 'rails_helper'

module Devx
  RSpec.describe Event, type: :model do
    let(:event){ FactoryGirl.create(:devx_event) }

    describe 'name' do
      it 'should be invalid if blank' do
        event.name = ''
        expect(event).not_to be_valid
      end

      it 'should be valid if present' do
        expect(event).to be_valid
      end
    end

    describe 'start time' do
      it 'should be invalid if blank' do
        event.start_time = ''
        expect(event).not_to be_valid
      end

      it 'should be valid if present' do
        expect(event).to be_valid
      end
    end
  end
end
