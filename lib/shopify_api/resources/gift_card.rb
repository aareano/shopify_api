module ShopifyAPI
  class GiftCard < Base
    # TODO: is 'balance' mutable?
    cattr_reader :mutable_attributes do
      [:currency, :expires_on, :note]
    end

    def disable
      load_attributes_from_response(post(:disable))
    end
  end
end
