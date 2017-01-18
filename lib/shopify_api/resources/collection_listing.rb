module ShopifyAPI
  class CollectionListing < Base
    init_prefix :application

    cattr_reader :prefix_option_keys do
      [:application_id]
    end

    def product_ids(options = {})
      get("#{collection_id}/product_ids", options[:params])
    end
  end
end
