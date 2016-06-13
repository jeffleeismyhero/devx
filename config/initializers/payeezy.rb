# require 'payeezy'

# module PayeezyTransaction
#   def self.process(amount, cc_type, ch_name, cc_number, exp_date, cvv)
#     transaction = Payeezy::Transactions.new(
#       url: 'https://api-cert.payeezy.com/v1/transactions',
#       apikey: Devx::ApplicationSetting.find(1).settings['payeezy_api_key'],
#       apisecret: Devx::ApplicationSetting.find(1).settings['payeezy_api_secret'],
#       token: Devx::ApplicationSetting.find(1).settings['payeezy_api_token']
#     ) rescue nil

#     params = {
#       method: 'credit_card',
#       amount: amount,
#       currency_code: 'USD',
#       credit_card: {
#         type: cc_type,
#         cardholder_name: ch_name,
#         card_number: cc_number,
#         exp_date: exp_date,
#         cvv: cvv
#       }
#     }

#     response = transaction.transact('purchase', params)

#     puts response.inspect

#     if response['transaction_status'] == 'approved'
#       return true
#     else
#       return false
#     end
#   end
# end