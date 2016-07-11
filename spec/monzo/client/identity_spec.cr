require "../../spec_helper"

describe Monzo::Client do
  it "can fetch an identity" do
    client = Monzo::Client.new(ENV["MONZO_TOKEN"])
    identity = client.identity

    identity.should be_a(Monzo::Identity)
    identity.authenticated.should eq(true)
    identity.client_id.should_not be(nil)
    identity.user_id.should_not be(nil)
  end
end
