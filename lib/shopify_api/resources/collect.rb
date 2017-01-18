module ShopifyAPI
  # For adding/removing products from custom collections
  class Collect < Base
    # TODO: is 'featured' mutable?
    cattr_reader :mutable_attributes do
      [:position, :sort_value]
    end
  end
end
