module ShopifyAPI
  class Checkout < Base
    cattr_reader :mutable_attributes do
      [:email, :handle, :reservation_time, :shipping_address, :shipping_line]
    end
  end
end
