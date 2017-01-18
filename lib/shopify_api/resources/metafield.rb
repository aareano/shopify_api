module ShopifyAPI
  class Metafield < Base
    include DisablePrefixCheck

    conditional_prefix :resource, true

    cattr_reader :prefix_option_keys do
      [:resource_id, :resource_type]
    end

    cattr_reader :mutable_attributes do
      [:description, :value, :value_type]
    end

    def value
      return if attributes["value"].nil?
      attributes["value_type"] == "integer" ? attributes["value"].to_i : attributes["value"]
    end
  end
end
