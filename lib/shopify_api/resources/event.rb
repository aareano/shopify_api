module ShopifyAPI
  class Event < Base
    include DisablePrefixCheck

    conditional_prefix :resource, true

    cattr_reader :prefix_option_keys do
      [:resource_id]
    end
  end
end
