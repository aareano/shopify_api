module ShopifyAPI
  class Province < Base
    init_prefix :country

    cattr_reader :prefix_option_keys do
      [:country_id]
    end
  end
end
