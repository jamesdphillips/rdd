module Mailgun
  class Resource
    extend Forwardable

    BASE_URL = %(https://api.mailgun.net/v2)

    def_delegators :connection, :get, :post, :put, :delete

    def connection
      @connection ||= Faraday.new(BASE_URL) do |config|
        config.basic_auth "api", ENV["MAILGUN_KEY"]
        config.adapter :excon

        config.request :url_encoded

        config.response :json, content_type: /\bjson$/
        config.response :mashify
        config.response :logger
      end
    end
  end
end

