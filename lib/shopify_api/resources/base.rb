require 'shopify_api/version'

module ShopifyAPI
  class Base < ActiveResource::Base
    cached_resource ttl: 60

    class InvalidSessionError < StandardError; end
    extend Countable
    self.timeout = 90
    self.include_root_in_json = false
    self.headers['User-Agent'] = ["ShopifyAPI/#{ShopifyAPI::VERSION}",
                                  "ActiveResource/#{ActiveResource::VERSION::STRING}",
                                  "Ruby/#{RUBY_VERSION}"].join(' ')

    def self.prefix_option_keys
      []
    end

    def prefix_option_keys
      self.class.prefix_option_keys
    end

    def self.mutable_attributes
      []
    end

    def mutable_attributes
      self.class.mutable_attributes
    end

    def self.from_seed(seed, reload = false)
      return Shop.current if seed[:class_name] == 'ShopifyAPI::Shop'

      seed.symbolize_keys!
      raise 'Seed does not have id.' if seed[:id].nil?

      resource_class = ObjectSpace.each_object(ShopifyAPI::Base.singleton_class).find do |klass|
        klass.name == seed[:class_name]
      end
      raise "Invalid class_name #{seed[:class_name]}." if resource_class.nil?

      params = seed.reject { |key, value| [:id, :class_name].include? key }
      resource_class.find(seed[:id], params: params, reload: reload)
    end

    # a collection of information sufficient to find any ShopifyAPI instance
    def seed
      return { class_name: self.class.name } if is_a? Shop
      {
        class_name: self.class.name,
        id: id
      }.merge(@prefix_options)
    end

    def encode(options = {})
      same = dup
      same.attributes = {self.class.element_name => same.attributes} if self.class.format.extension == 'json'

      same.send("to_#{self.class.format.extension}", options)
    end

    def as_json(options = nil)
      root = options[:root] if options.try(:key?, :root)
      if include_root_in_json
        root = self.class.model_name.element if root == true
        { root => serializable_hash(options) }
      else
        serializable_hash(options)
      end
    end

    class << self
      if ActiveResource::Base.respond_to?(:_headers) && ActiveResource::Base.respond_to?(:_headers_defined?)
        def headers
          if _headers_defined?
            _headers
          elsif superclass != Object && superclass.headers
            superclass.headers
          else
            _headers ||= {}
          end
        end
      else
        def headers
          if defined?(@headers)
            @headers
          elsif superclass != Object && superclass.headers
            superclass.headers
          else
            @headers ||= {}
          end
        end
      end

      def activate_session(session)
        raise InvalidSessionError.new("Session cannot be nil") if session.nil?
        self.site = session.site
        self.headers.merge!('X-Shopify-Access-Token' => session.token)
      end

      def clear_session
        self.site = nil
        self.password = nil
        self.user = nil
        self.headers.delete('X-Shopify-Access-Token')
      end

      def init_prefix(resource)
        init_prefix_explicit(resource.to_s.pluralize, "#{resource}_id")
      end

      def init_prefix_explicit(resource_type, resource_id)
        self.prefix = "/admin/#{resource_type}/:#{resource_id}/"

        define_method resource_id.to_sym do
          @prefix_options[resource_id]
        end
      end
    end

    def persisted?
      !id.nil?
    end

    private

    def only_id
      encode(:only => :id, :include => [], :methods => [])
    end
  end
end
