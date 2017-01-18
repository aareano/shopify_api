module ShopifyAPI
  class Variant < Base
    include Metafields
    include DisablePrefixCheck

    conditional_prefix :product

    cattr_reader :prefix_option_keys do
      [:product_id]
    end

    # TODO: are 'grams' and 'inventory_management' mutable?
    # :metafields
    cattr_reader :mutable_attributes do
      [:option1, :price, :sku, :position, :inventory_policy,
       :compare_at_price, :fulfillment_service, :option2, :option3, :taxable,
       :barcode, :image_id, :weight, :weight_unit, :requires_shipping,
       :inventory_management, :inventory_quantity, :old_inventory_quantity,
       :inventory_quantity_adjustment]
    end
  end
end
