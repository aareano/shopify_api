module ShopifyAPI
  class CustomCollection < Base
    include Events
    include Metafields

    # :metafields
    cattr_reader :mutable_attributes do
      [:body_html, :handle, :image, :published_scope, :published,
       :sort_order, :template_suffix, :title]
    end

    # #image is normally only defined when the image is not null,
    # so provide this convenience method for consistency
    def image
      attributes['image']
    end

    def products
      Product.find(:all, :params => {:collection_id => self.id})
    end

    def add_product(product)
      Collect.create(:collection_id => self.id, :product_id => product.id)
    end

    def remove_product(product)
      collect = Collect.find(:first, :params => {:collection_id => self.id, :product_id => product.id})
      collect.destroy if collect
    end
  end
end
