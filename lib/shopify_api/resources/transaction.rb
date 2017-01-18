module ShopifyAPI
  class Transaction < Base
    init_prefix :order

    cattr_reader :prefix_option_keys do
      [:order_id]
    end
  end
end
