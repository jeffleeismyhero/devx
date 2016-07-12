require 'rails_helper'

module Devx
  RSpec.describe AccountTransaction, type: :model do
    let(:account_transaction){ FactoryGirl.create(:devx_account_transaction) }

    ## Title unit test
    describe 'user' do
      it 'should be invalid if user is blank' do
        skip
        account_transaction.user = nil
        expect(account_transaction).not_to be_valid
      end

      it 'should be valid if user is present' do
        skip
        expect(account_transaction).to be_valid
      end
    end

    describe 'transaction_type' do
      it 'should be invalid if transaction_type is blank' do
        skip
        account_transaction.transaction_type = ''
        expect(account_transaction).not_to be_valid
      end

      it 'should be valid if transaction_type is present' do
        skip
        expect(account_transaction).to be_valid
      end
    end

    describe 'payment_method' do
      it 'should be invalid if payment_method is blank' do
        skip
        account_transaction.payment_method = ''
        expect(account_transaction).not_to be_valid
      end

      it 'should be valid if payment_method is present' do
        skip
        expect(account_transaction).to be_valid
      end
    end

    describe 'amount' do
      it 'should be invalid if amount < 0.01' do
        skip
        account_transaction.amount = 0.00
        expect(account_transaction).not_to be_valid
      end

      it 'should be valid if amount > 0.00' do
        skip
        expect(account_transaction).to be_valid
      end
    end

  end
end