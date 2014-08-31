module Reddit
  class Resource
    extend Forwardable

    BASE_URL = %(http://api.reddit.com/api).freeze

    private

    def_delegators :connection, :get

    def connection
      @connection ||= Faraday.new(BASE_URL) do |config|
        config.adapter :excon
        config.request :url_encoded
        config.response :logger

        # accept json
      end
    end
  end
end
