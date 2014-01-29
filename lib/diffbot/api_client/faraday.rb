module Diffbot
  class APIClient 
    class FaradayMiddleware
      class ParseJson < Faraday::Response::Middleware
        WHITESPACE_REGEX = /\A^\s*$\z/

        def parse(body)
          case body
          when WHITESPACE_REGEX, nil
            nil
          else
            JSON.parse(body, :symbolize_names => true)
          end
        end

        def on_complete(env)
          if respond_to?(:parse)
            env[:body] = parse(env[:body]) unless unparsable_status_codes.include?(env[:status])
          end
        end

        def unparsable_status_codes
          [204, 301, 302, 304]
        end
      end
    end
  end
end

Faraday::Response.register_middleware :parse_json => Diffbot::APIClient::FaradayMiddleware::ParseJson