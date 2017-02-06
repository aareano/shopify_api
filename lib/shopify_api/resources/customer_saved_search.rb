require 'shopify_api/resources/customer'

module ShopifyAPI
  class CustomerSavedSearch < Base
    cattr_reader :mutable_attributes do
      [:name, :query]
    end

    def customers(params = {})
      Customer.search(params.merge({:query => self.query}))
    end
  end
end
