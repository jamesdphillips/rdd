module Reddit
  module Cache
    EXPIRES_IN = 30.minutes.freeze

    def cache(url, params)
      Rails.cache.fetch([url, params], expires_in: EXPIRES_IN) do
        yield
      end
    end
  end
end
