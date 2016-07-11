require "../../spec_helper"

describe Monzo::Client do
  it "can ping Monzo" do
    client = Monzo.new(ENV["MONZO_TOKEN"])
    client.ping.should eq(true)
  end
end
