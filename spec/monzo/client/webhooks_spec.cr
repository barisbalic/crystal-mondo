require "../../spec_helper"

describe Monzo::Client do
  it "can register a webhook" do
    client = Monzo::Client.new(ENV["MONZO_TOKEN"])
    account = client.accounts.first

    webhook = client.register_webhook(account.id, "https://localhost")
    webhook.should be_a(Monzo::Webhook)
    webhook.account_id.should eq(account.id)
    webhook.url.should eq("https://localhost")

    # client.register_webhook(account, "https://localhost").should be_a(Monzo::Webhook)
  end

  it "can fetch webhooks" do
    client = Monzo::Client.new(ENV["MONZO_TOKEN"])
    account = client.accounts.first

    client.webhooks(account.id).should be_a(Array(Monzo::Webhook))
    client.webhooks(account).should be_a(Array(Monzo::Webhook))
  end

  it "can delete a webhook" do
    client = Monzo::Client.new(ENV["MONZO_TOKEN"])
    account = client.accounts.first
    webhook = client.webhooks(account.id).first

    client.delete_webhook(webhook.id).should be_true

    another_webhook = client.register_webhook(account, "http://another")
    client.delete_webhook(another_webhook).should be_true
  end
end
