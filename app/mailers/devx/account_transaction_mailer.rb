module Devx
  class AccountTransactionMailer < ApplicationMailer
    def below_twenty(recipient, balance)
      @balance = balance
      @recipient = recipient

      mail to: @recipient,
      from: 'noreply@catholichigh.org',
      subject: 'Low Balance Notification'
    end

    def below_ten(recipient, balance)
      @balance = balance
      @recipient = recipient

      mail to: @recipient,
      from: 'noreply@catholichigh.org',
      subject: 'Low Balance Notification'
    end

    def below_five(recipient, balance)
      @balance = balance
      @recipient = recipient

      mail to: @recipient,
      from: 'noreply@catholichigh.org',
      subject: 'Low Balance Notification'
    end

    def below_zero(recipient, balance)
      @balance = balance
      @recipient = recipient

      mail to: @recipient,
      from: 'noreply@catholichigh.org',
      subject: 'Low Balance Notification'
    end
  end
end
