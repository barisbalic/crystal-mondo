require "../../spec_helper"

describe Monzo::Client do
  it "can insert feed items" do
    client = Monzo::Client.new(ENV["MONZO_TOKEN"])

    account = client.accounts.first
    # TODO report image error
    # params = {"title" => "Red Tee!", "image_url" => "https://s.gravatar.com/avatar/380ec9b091a6f8d876640230c918c2cc"}
    params = {"title" => "NYAN NYAN NYAN NYAN", "image_url" => "https://monzo.com/docs/images/nyanfeed-93ee2ecb.gif"}

    client.feed_item(account.id, params).should be_true
    client.feed_item(account, params).should be_true

    params = {
      "body" =>     "Oh what a terrible night to have a curse.",
      "title" =>    "Playr Tee!",
      "image_url" => "https://lh3.googleusercontent.com/-n2G3bfJQuPI/AAAAAAAAAAI/AAAAAAAAAAA/AOkcYIvpFfQdBJn4h_0Wf7am1Xv84ihiPQ/mo/photo.jpg"
    }

    client.feed_item(account.id, "http://barisbaris.com", params).should be_true
    client.feed_item(account, "http://barisbaris.com", params).should be_true
  end
end
