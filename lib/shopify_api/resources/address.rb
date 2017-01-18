module ShopifyAPI
  class Address < Base
    init_prefix :customer

    cattr_reader :mutable_attributes do
      [:first_name, :address1, :address2, :city, :company, :country,
       :country_code, :country_name, :default, :last_name, :name, :phone,
       :province, :province_code, :zip]
    end
  end
end
