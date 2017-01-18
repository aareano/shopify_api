module ShopifyAPI
  class UsageCharge < Base
    init_prefix :recurring_application_charge

    cattr_reader :prefix_option_keys do
      [:recurring_application_charge_id]
    end
  end
end
