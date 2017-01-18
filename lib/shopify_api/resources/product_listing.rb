module ShopifyAPI
  class ProductListing < Base
    init_prefix :application

    cattr_reader :prefix_option_keys do
      [:application_id]
    end

    def self.product_ids(options = {})
      get(:product_ids, options[:params])
    end
  end
end
