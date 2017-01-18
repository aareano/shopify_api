require 'shopify_api/resources/customer'

module ShopifyAPI
  class CustomerSavedSearch < Base
    cattr_reader :mutable_attributes do
      [:name, :query]
    end

    def customers(params = {})
      Customer.search(params.merge({:saved_search_id => self.id}))
    end
  end
end
