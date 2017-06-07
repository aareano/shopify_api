module ShopifyAPI
  class ProductListing < Base
    self.primary_key = :product_id

    cattr_reader :prefix_option_keys do
      [:application_id]
    end

    def self.product_ids
      get(:product_ids)
    end
  end
end
