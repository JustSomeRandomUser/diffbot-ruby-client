module Diffbot
  class APIClient

    # Diffbot Article API class
    class Article < GenericAPI
      ALLOWED_PARAMS = [:fields, :timeout, :callback]
      DEFAULT_VERSION = 2

      # Initializes a new Article API object
      #
      # @param client [Diffbot::APIClient]
      # @param options [Hash]
      # @return [Diffbot::APIClient::Article]
      def initialize client, options = {}
        @version = options.delete(:version) || DEFAULT_VERSION
        super(client, options)
      end

      # Return request path
      #
      # @return [String]
      def path
        "v#{@version}/article"
      end

      private

      def parse_params source
        target = {}

        ALLOWED_PARAMS.each do |param|
          next unless source.keys.include?(param)

          case param
          when :fields
            target[param] = source[param].is_a?(Array) ? source[param].join(",") : source[param]
          else
            target[param] = source[param]
          end
        end

        target
      end
    end

  end
end
