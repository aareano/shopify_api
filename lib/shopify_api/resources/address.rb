module ShopifyAPI
  class Address < Base
    init_prefix :customer

    cattr_reader :prefix_option_keys do
      [:customer_id]
    end

    cattr_reader :mutable_attributes do
      [:first_name, :address1, :address2, :city, :company, :country,
       :country_code, :country_name, :default, :last_name, :name, :phone,
       :province, :province_code, :zip]
    end

    def customer_id
      @prefix_options[:customer_id]
    end
  end
end
