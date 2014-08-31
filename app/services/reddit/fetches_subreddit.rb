module Reddit
  class FetchesSubreddit < Resource
    include Cache

    # @param name [String] name of the subreddit to fetch
    def initialize(name)
      @name = name
    end

    # Fetch given subreddit details
    def fetch
      url = "/r/#{@name}/about"

      cache(url, {}) do
        response = get(url)

        case response.status
        when 200
          Oj::Doc.open(response.body) do |doc|
            details = doc.fetch("/data")
            Hashie::Mash.new(details)
          end
        when 302, 404
          # doesn't exist
        else
          raise "Unknown error occurred"
        end
      end
    end
  end
end
