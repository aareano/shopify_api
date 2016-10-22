module ShopifyAPI
  class Connection < ActiveResource::Connection
    attr_reader :response

    RETRY_AFTER = 2 # seconds
    RETRY_TIMES = 5 # times

    module ResponseCapture
      def handle_response(response)
        @response = super
      end
    end

    include ResponseCapture

    module RequestNotification
      def request(method, path, *arguments)
        retry_times = RETRY_TIMES
        begin
          super.tap do |response|
            notify_about_request(response, arguments)
          end
        rescue ActiveResource::ClientError => e
          raise unless e.response.code.to_i == 429 && !(retry_times -= 1).zero?
          sleep((e.response['Retry-After'].presence || RETRY_AFTER).to_i)
          retry
        end
      rescue => e
        notify_about_request(e.response, arguments) if e.respond_to?(:response)
        raise
      end

      def notify_about_request(response, arguments)
        ActiveSupport::Notifications.instrument("request.active_resource_detailed") do |payload|
          payload[:response] = response
          payload[:data]     = arguments
        end
      end
    end

    include RequestNotification
  end
end
