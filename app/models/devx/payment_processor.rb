module Devx
  class PaymentProcessor

    def self.process(obj, obj_data, payment_details, ipaddr)
        settings = Devx::ApplicationSetting.find_or_create_by(id: 1).settings

        if settings['stripe'].present?
          process_stripe(obj, obj_data, payment_details, ipaddr)
        elsif settings['diamond_mind'].present?
          process_diamond_mind(obj, obj_data, payment_details, ipaddr)
        end
    end

    def self.process_stripe(obj, obj_data, payment_details, ipaddr)
      charge = Stripe::Charge.create(
        amount: (payment_details[:amount] * 100).to_i,
        currency: 'usd',
        source: obj_data.submission_content[:stripe_token],
        description: "Payment for #{obj.name}"
      )
      puts obj_data.inspect
      obj_data.stripe_id = charge.id
    end

    def self.process_diamond_mind(obj, obj_data, payment_details, ipaddr)
      settings = Devx::ApplicationSetting.find_or_create_by(id: 1).settings

      if DiamondMind::Processor.process(settings['diamond_mind_username'], settings['diamond_mind_password'], obj, obj_data, payment_details, ipaddr) == 'Approved'
        return true
      else
        return false
      end
    end


  end
end
