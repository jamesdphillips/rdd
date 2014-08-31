module Helpers
  module VCR
    require "vcr"
    require "faraday"

    ::VCR.configure do |config|
      config.cassette_library_dir = "spec/cassettes"
      config.hook_into :excon
      config.configure_rspec_metadata!
    end
  end
end
