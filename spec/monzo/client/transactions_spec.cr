require "../../spec_helper"

describe Monzo::Client do
  it "can fetch account transactions" do
    client = Monzo.new(ENV["MONZO_TOKEN"])

    account = client.accounts.first
    transactions = client.transactions(account.id)
    transactions.should be_a(Array(Monzo::Transaction))

    transactions = client.transactions(account)
    transactions.should be_a(Array(Monzo::Transaction))
  end

  it "can fetch a specific transaction" do
    client = Monzo.new(ENV["MONZO_TOKEN"])
    account = client.accounts.first
    transactions = client.transactions(account)
    transaction = client.transaction(transactions.first.id)

    transaction.should be_a(Monzo::Transaction)
  end

  it "can annotate a specific transaction" do
    client = Monzo.new(ENV["MONZO_TOKEN"])
    account = client.accounts.first

    transaction = client.transactions(account).first

    annotations = [{"hero", "hanzo"}]
    transaction = client.annotate(transaction.id, annotations)

    transaction.should be_a(Monzo::Transaction)
    transaction.metadata["hero"].should eq("hanzo")

    annotations = [{"hero", "genji"}]
    transaction = client.annotate(transaction, annotations)
    transaction.metadata["hero"].should eq("genji")

    transaction = client.annotate(transaction.id, "hero", "zenyatta")
    transaction.metadata["hero"].should eq("zenyatta")

    transaction = client.annotate(transaction, "hero", "pharah")
    transaction.metadata["hero"].should eq("pharah")
  end

  it "can remove an annotation from a transaction" do
    client = Monzo.new(ENV["MONZO_TOKEN"])
    account = client.accounts.first

    transaction = client.transactions(account).first

    annotations = [
      {"first", "reaper"},
      {"second", "blackwidow"},
      {"third", "junkrat"},
      {"fourth", "roadhog"}
    ]

    transaction = client.annotate(transaction, annotations)

    transaction = client.remove_annotation(transaction, "first")
    transaction.metadata["first"]?.should eq(nil)

    transaction = client.remove_annotation(transaction.id, "second")
    transaction.metadata["second"]?.should eq(nil)

    transaction = client.remove_annotations(transaction, ["third"])
    transaction.metadata["third"]?.should eq(nil)

    transaction = client.remove_annotations(transaction.id, ["fourth"])
    transaction.metadata["fourth"]?.should eq(nil)
  end
end
