# frozen_string_literal: true

# The base ApiClient class that provides methods
# to make HTTP requests to the external services
module ApiClients
  class ApiClient
    CONTENT_TYPE_JSON = "application/json"

    attr_reader :api_path, :api_key, :content_type

    def initialize(api_path: nil, api_key: nil, content_type: CONTENT_TYPE_JSON)
      @api_path = api_path || self.class::API_PATH
      @api_key = api_key || ENV.fetch("#{self.class::CLIENT}_API_KEY", nil)
      @content_type = content_type
    end

    def get(endpoint, params = {})
      request(:get, endpoint, params:)
    end

    def post(endpoint, body = {})
      request(:post, endpoint, body:)
    end

    def put(endpoint, body = {})
      request(:put, endpoint, body:)
    end

    def delete(endpoint, params = {})
      request(:delete, endpoint, params:)
    end

    private

    def request(method, endpoint, body: nil, params: nil)
      request = Typhoeus::Request.new(
        [api_path, endpoint].join, method:, body:, params:, headers:
      )

      request.run
      response(request.response)
    end

    def response(response)
      { code: response.code, body: JSON.parse(response.body) }
    end

    def headers
      {
        "Authorization": "Bearer #{api_key}",
        "Content-Type": content_type
      }
    end
  end
end
