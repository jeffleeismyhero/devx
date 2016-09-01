module Devx
  class PaymentProcessor

    def self.process(obj, obj_data, amount, ch_first_name, ch_last_name, cc_number, cc_exp, cc_cvv, ipaddr)
        settings = Devx::ApplicationSetting.find_or_create_by(id: 1).settings

        if settings['stripe'].present?
          process_stripe(obj, obj_data, amount, ch_first_name, ch_last_name, cc_number, cc_exp, cc_cvv, ipaddr)
        elsif settings['diamond_mind'].present?
          process_diamond_mind(obj, obj_data, amount, ch_first_name, ch_last_name, cc_number, cc_exp, cc_cvv, ipaddr)
        end
    end

    def self.process_stripe(obj, obj_data, amount, ch_first_name, ch_last_name, cc_number, cc_exp, cc_cvv, ipaddr)
    end

    def self.process_diamond_mind(obj, obj_data, amount, ch_first_name, ch_last_name, cc_number, cc_exp, cc_cvv, ipaddr)
      settings = Devx::ApplicationSetting.find_or_create_by(id: 1).settings

      if DiamondMind::Processor.process(settings['diamond_mind_username'], settings['diamond_mind_password'], obj, obj_data, amount, ch_first_name, ch_last_name, cc_number, cc_exp, cc_cvv, ipaddr) == 'Approved'
        return true
      else
        return false
      end
    end


  end
end
