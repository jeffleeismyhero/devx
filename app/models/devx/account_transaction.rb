module Devx
  class AccountTransaction < ActiveRecord::Base
    belongs_to :person

    scope :pending, -> { where(processed_at: nil) }
    scope :imported, -> { where(imported: true) }

    validates :person, presence: true
    validates :transaction_type, presence: true
    validates :payment_method, presence: true
    validates :amount, presence: true, numericality: { greater_than: 0 }

    def self.per_page
      return 20
    end

    def payeezy
      require 'payeezy'

      return Payeezy::Transactions.new(
        url: 'https://api.payeezy.com/v1/transactions',
        apikey: Devx::ApplicationSetting.find_or_create_by(id: 1).settings['payeezy_api_key'],
        apisecret: Devx::ApplicationSetting.find_or_create_by(id: 1).settings['payeezy_api_secret'],
        token: Devx::ApplicationSetting.find_or_create_by(id: 1).settings['payeezy_api_token']
      ) rescue nil
    end

    def process(amount, cc_type, ch_name, cc_number, exp_date, cvv)
      if Devx::ApplicationSetting.find_or_create_by(id: 1).settings['payeezy']

        params = {
          method: 'credit_card',
          amount: (amount * 100),
          currency_code: 'USD',
          credit_card: {
            type: cc_type,
            cardholder_name: ch_name,
            card_number: cc_number,
            exp_date: exp_date,
            cvv: cvv
          }
        }

        response = payeezy.transact('purchase', params)

        puts response.inspect

        if response['transaction_status'] == 'approved'
          return true
        else
          return false
        end
      end
    end

  end
end
