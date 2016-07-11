require "../../spec_helper"

describe Monzo::Client do
  it "can generate a temporary upload URL" do
    client = Monzo::Client.new(ENV["MONZO_TOKEN"])
    response = client.upload_attachment("finn.png", "image/png")
    response.should be_a(Monzo::TemporaryAttachmentData)
  end

  it "can register an attachment" do
    client = Monzo::Client.new(ENV["MONZO_TOKEN"])
    account = client.accounts.first
    transaction = client.transactions(account.id).first

    url = "https://lh3.googleusercontent.com/-n2G3bfJQuPI/AAAAAAAAAAI/AAAAAAAAAAA/AOkcYIvpFfQdBJn4h_0Wf7am1Xv84ihiPQ/mo/photo.jpg"

    attachment = client.register_attachment(transaction.id, url, "image/jpg")
    attachment.should be_a(Monzo::Attachment)
  end

  it "can degregister an attachment" do
    client = Monzo::Client.new(ENV["MONZO_TOKEN"])
    account = client.accounts.first
    transaction = client.transactions(account.id).first

    url = "https://lh3.googleusercontent.com/-n2G3bfJQuPI/AAAAAAAAAAI/AAAAAAAAAAA/AOkcYIvpFfQdBJn4h_0Wf7am1Xv84ihiPQ/mo/photo.jpg"

    attachment = client.register_attachment(transaction.id, url, "image/jpg")
    client.deregister_attachment(attachment.id).should be_true
  end
end
