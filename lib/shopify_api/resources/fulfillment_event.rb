module ShopifyAPI
  class FulfillmentEvent < Base
    self.prefix = '/admin/orders/:order_id/fulfillments/:fulfillment_id/'
    self.collection_name = 'events'
    self.element_name = 'event'

    cattr_reader :prefix_option_keys do
      [:order_id, :fulfillment_id]
    end

    def order_id
      @prefix_options[:order_id]
    end

    def fulfillment_id
      @prefix_options[:fulfillment_id]
    end

    def fulfillment
      Fulfillment.find(fulfillment_id, params: { order_id: order_id })
    end
  end
end
