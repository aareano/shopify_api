module ShopifyAPI
  class Customer < Base
    include Metafields

    # :metafields
    cattr_reader :mutable_attributes do
      [:accepts_marketing, :tax_exempt, :email, :first_name, :last_name, :note,
       :tags]
    end

    def orders
      Order.find(:all, params: {customer_id: self.id})
    end

    def self.search(params)
      find(:all, from: :search, params: params)
    end

    def account_activation_url
      resource = post(:account_activation_url, {}, only_id)
      data = ActiveSupport::JSON.decode(resource.body.to_s)
      result = nil

      if data.key?('account_activation_url')
        result = data['account_activation_url']
      end
      result
    end
  end
end
