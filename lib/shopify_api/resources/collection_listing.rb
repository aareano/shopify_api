module ShopifyAPI
  class CollectionListing < Base
    self.primary_key = :collection_id

    cattr_reader :prefix_option_keys do
      [:application_id]
    end

    def product_ids
      get(:product_ids)
    end
  end
end
