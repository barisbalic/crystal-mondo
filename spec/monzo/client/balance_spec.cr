require "../../spec_helper"

describe Monzo::Client do
  it "can fetch the balance for an account" do
    client = Monzo::Client.new(ENV["MONZO_TOKEN"])
    account = client.accounts.first
    balance = client.balance(account.id)

    balance.should be_a(Monzo::Balance)
    balance.balance.should be_a(Int64)
    balance.currency.should be_a(String)
    balance.spend_today.should be_a(Int64)

    balance = client.balance(account)
    balance.should be_a(Monzo::Balance)
    balance.balance.should be_a(Int64)
    balance.currency.should be_a(String)
    balance.spend_today.should be_a(Int64)
  end
end
