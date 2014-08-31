require "./app/services/reddit/fetches_listing"

describe Reddit::FetchesListing, helpers: :vcr do
  let(:subreddit) { "lifeprotips" }
  let(:sort) { "top" }
  let(:service) { Reddit::FetchesListing.new(subreddit, sort) }

  before(:all) { VCR.insert_cassette(:reddit, record: :new_episodes) }
  after(:all) { VCR.eject_cassette(:reddit) }

  describe "#fetch" do
    it "returns list of links" do
      expect(service.fetch).to_not be_nil
    end

    it "returns links as hashie resources" do
      expect(service.fetch.first).to be_a Hashie::Mash
    end

    it "returns no more than 100 links" do
      expect(service.fetch.length).to be <= 100
    end

    context "unknown subreddit" do
      let(:subreddit) { "asdfjhaklsdfjalskdfjasfd" }

      it "returns nil" do
        expect(service.fetch).to be_nil
      end
    end
  end
end

