require 'csv'

if records = CSV.read("#{Rails.root}/balances.csv", headers: true)
  logfile = File.open("#{Rails.root}/log/import.log", "a")
  logfile.sync = true
  logger = Logger.new(logfile)

  records.each_with_index do |record, index|
    begin
      school_id = record[0].to_s.squish,
      first_name = record[1].to_s.squish,
      last_name = record[2].to_s.squish,
      balance = record[3].to_f

      person = Devx::Person.find_by(school_id: record[0].to_s.squish)

      if person.nil?
        person = Devx::Person.new(
          school_id: record[0].to_s.squish,
          first_name: first_name,
          last_name: last_name
        )

        logger.info "[PERSON NOT PRESENT] #{person.inspect} is being created"

        if person.valid? && person.save
          logger.info "[PERSON SAVED] #{person.inspect}"
        end
      end

      transaction = Devx::AccountTransaction.find_by(person: person, created_at: '2016-06-13'.in_time_zone)

      if transaction.nil?
        transaction = Devx::AccountTransaction.new(
          person: person,
          transaction_type: 'Credit',
          payment_method: 'Rollover',
          amount: balance,
          created_at: '2016-06-13'.in_time_zone
        )

        if transaction.save(validate: false)
          logger.info "[TRANSACTION POSTED] Successfully posted #{transaction.inspect}"
        else
          logger.warn "[TRANSACTION DECLINED] Failed to post #{transaction.inspect}"
        end
      end
    rescue => e
      logger.warn "[FATAL ERROR] Error occurred while posting transaction #{transaction.inspect} for customer #{person.inspect} - #{e}"
    end
  end

end
