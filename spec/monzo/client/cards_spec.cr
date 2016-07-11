require "../../spec_helper"

describe Monzo::Client do
  it "can fetch all cards for an account" do
    client = Monzo.new(ENV["MONZO_TOKEN"])
    account = client.accounts.first

    client.cards(account.id).should be_a(Array(Monzo::Card))
    client.cards(account).should be_a(Array(Monzo::Card))
  end

  it "can freezes a card" do
    client = Monzo.new(ENV["MONZO_TOKEN"])
    account = client.accounts.first
    card = client.cards(account.id).first

    client.freeze(card.id).should eq(true)
  end

  it "can unfreezes a card" do
    client = Monzo.new(ENV["MONZO_TOKEN"])
    account = client.accounts.first
    card = client.cards(account.id).first

    client.unfreeze(card.id).should eq(true)
  end
end
