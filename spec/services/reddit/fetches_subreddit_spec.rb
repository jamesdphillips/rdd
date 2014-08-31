require "./app/services/reddit/fetches_subreddit"

describe Reddit::FetchesSubreddit, helpers: :vcr do
  let(:name) { "lifeprotips" }
  let(:service) { Reddit::FetchesSubreddit.new(name) }

  before(:all) { VCR.insert_cassette(:reddit, record: :new_episodes) }
  after(:all) { VCR.eject_cassette(:reddit) }

  context "valid subreddit" do
    it "returns subreddit details" do
      expect(service.fetch).to be_a Hashie::Mash
    end
  end

  context "invalid subreddit" do
    let(:name) { "kajsdflkajsdflkjasdflkajsdfl" }

    it "returns nil" do
      expect(service.fetch).to be_nil
    end
  end
end

