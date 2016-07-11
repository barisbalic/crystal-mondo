require "../../spec_helper"

describe Monzo::Client do
  it "can fetch accounts" do
    client = Monzo::Client.new(ENV["MONZO_TOKEN"])
    client.accounts.should be_a(Array(Monzo::Account))
  end
end
