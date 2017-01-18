module ShopifyAPI
  class OrderRisk < Base
    init_prefix :order

    cattr_reader :prefix_option_keys do
      [:order_id]
    end

    cattr_reader :mutable_attributes do
      [:cause_cancel, :message, :recommendation, :score, :source]
    end

    self.collection_name = 'risks'
    self.element_name = 'risk'
  end
end
