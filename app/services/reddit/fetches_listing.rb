module Reddit
  class FetchesListing < Resource
    include Cache

    # @param subreddit [String]
    def initialize(subreddit, sort)
      @subreddit, @sort = subreddit, sort
    end

    # @param time_frame [String] hour, day, week & monthly
    def fetch(time_frame: "day")
      url = "/r/#{@subreddit}/#{@sort}"
      params = { t: time_frame, limit: 100 }

      cache(url, params) do
        response = get(url, params)
        parse_response(response)
      end
    end

    private

    def parse_response(response)
      case response.status
      when 200
        Oj::Doc.open(response.body) do |doc|
          doc.move("data/children")

          links = doc.fetch
          links.map { |link| Hashie::Mash.new(link["data"]) }
        end
      when 302, 404
        # non existant subreddit
      else
        raise "Unknown response"
      end
    end
  end
end
