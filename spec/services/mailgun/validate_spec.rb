require "./app/services/mailgun/validate"

describe Mailgun::Validate, helpers: :vcr do
  let(:service) { Mailgun::Validate.new(email) }

  before(:all) { VCR.insert_cassette "mailgun" }
  after(:all) { VCR.eject_cassette "mailgun" }

  context "invalid email" do
    let(:email) { "invalid_email@;gmail.com" }

    it "#valid? returns false" do
      expect(service.valid?).to be_falsey
    end

    it "#suggestion returns a string" do
      expect(service.suggestion).to_not be_nil
    end
  end

  context "valid email" do
    let(:email) { "valid@email.com" }

    it "#valid? returns true" do
      expect(service.valid?).to be_truthy
    end
  end
end

