module Mailgun
  class Validate < Resource

    # @param email [String] address to validate
    def initialize(email)
      @email = email
    end

    # Whether given email address is valid
    def valid?
      response = validate
      response[:is_valid]
    end

    # If invalid suggestion for what was meant
    def suggestion
      response = validate
      response[:did_you_mean]
    end

    private

    def validate
      @response ||= get("address/validate", address: @email).body.with_indifferent_access
    end

  end
end

