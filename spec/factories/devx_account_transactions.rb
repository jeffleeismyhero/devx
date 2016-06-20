FactoryGirl.define do

  factory :devx_account_transaction, class: 'Devx::AccountTransaction' do
    user { build(:devx_user) }
    transaction_type 'debit'
    payment_method 'credit card'
    amount 1.00
  end
end