require 'rails_helper'

module Devx
  RSpec.describe AccountTransaction, type: :model do
    let(:account_transaction){ FactoryGirl.create(:devx_account_transaction) }

    ## Title unit test
    describe 'account transaction' do
      it 'should be invalid if person is blank' do
        account_transaction.person = nil
        expect(account_transaction).not_to be_valid
      end

      it 'should be valid if person is present' do
        expect(account_transaction).to be_valid
      end
    end

    describe 'transaction_type' do
      it 'should be invalid if transaction_type is blank' do
        account_transaction.transaction_type = ''
        expect(account_transaction).not_to be_valid
      end

      it 'should be valid if transaction_type is present' do
        expect(account_transaction).to be_valid
      end
    end

    describe 'payment_method' do
      it 'should be invalid if payment_method is blank' do
        account_transaction.payment_method = ''
        expect(account_transaction).not_to be_valid
      end

      it 'should be valid if payment_method is present' do
        expect(account_transaction).to be_valid
      end
    end

    describe 'amount' do
      it 'should be invalid if amount < 0.01' do
        account_transaction.amount = 0.00
        expect(account_transaction).not_to be_valid
      end

      it 'should be valid if amount > 0.00' do
        expect(account_transaction).to be_valid
      end
    end

  end
end
