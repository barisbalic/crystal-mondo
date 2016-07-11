require "../spec_helper"

describe Monzo::Client do
  it "raises an error when authentication fails" do
    client = Monzo.new("HAI")
    expect_raises(Monzo::Errors::Unauthorized) do
      client.accounts
    end
  end

  it "raises an error when the token has insufficient permissions for a request" do
    client = Monzo::Client.new(ENV["MONZO_TOKEN"])

    expect_raises(Monzo::Errors::Forbidden) do
      client.transactions("OHMY").should be_true
    end
  end

  it "raises an error when a service error occurs" do
    client = Monzo::Client.new(ENV["MONZO_TOKEN"])

    expect_raises(Monzo::Errors::BadRequest) do
      account = client.accounts.first
      params = {"shoryu" => "ken"}
      client.feed_item(account, params)
    end
  end
end
