module ShopifyAPI
  class Webhook < Base
    TOPICS = %w(
      app/uninstalled
      carts/create carts/update
      checkouts/create checkouts/delete checkouts/update
      collections/create collections/update collections/delete
      customer_groups/create customer_groups/update customer_groups/delete
      customers/create customers/delete customers/disable customers/enable customers/update
      fulfillment_events/create fulfillment_events/delete
      fulfillments/create fulfillments/update
      order_transactions/create
      orders/create orders/delete orders/updated orders/paid orders/cancelled orders/fulfilled orders/partially_fulfilled
      products/create products/update products/delete
      refunds/create
      shop/update
    ).freeze

    def self.resource_class_from_topic(topic)
      c = 'ShopifyAPI::' + topic.split('/')[0].classify
      c = (c == 'ShopifyAPI::OrderTransaction') ? 'ShopifyAPI::Transaction' : c
      c = (c == 'ShopifyAPI::Collection') ? 'ShopifyAPI::CustomCollection' : c
      Object.const_get(c)
    end

    def resource_class
      self.class.resource_class_from_topic(topic)
    end
  end
end
