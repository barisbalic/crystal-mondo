module Monzo
  class Client

    # Exposes methods for dealing with `FeedItem`s as defined by the
    # [Feed-items API documentation](https://monzo.com/docs/#feed-items).
    module FeedItems
      TYPE = "basic"

      # Creates a `FeedItem` to be displayed in the phone app for the specified *account*.
      #
      # ```
      # account = client.accounts.first
      # client.feed_item(account, {"GitHub Payment", "https://github.com/logo.png"}) # =>  true
      # ```
      def feed_item(account : Monzo::Account, params)
        feed_item(account.id, params)
      end

      # Creates a `FeedItem` to be displayed in the phone app for the specified *account_id*.
      def feed_item(account_id : String, params)
        body = feed_item_arguments(account_id, params)
        response = post("/feed", body.to_s)
        true
      end

      # Creates a `FeedItem` that will link to the specified *url* when clicked in the phone app, for a specified
      # *account*.
      #
      # ```
      # account = client.accounts.first
      # client.feed_item(account, "https://www.github.com", {"GitHub Payment", "https://github.com/logo.png"}) # => true
      # ```
      def feed_item(account : Monzo::Account, url : String, params)
        feed_item(account.id, url, params)
      end

      # Creates a `FeedItem` that will link to the specified *url* when clicked in the phone app, for a specified
      # *account_id*.
      def feed_item(account_id : String, url : String, params)
        body = feed_item_arguments(account_id, params)
        body.add("url", url)

        response = post("/feed", body.to_s)
        true
      end

      private def feed_item_arguments(account_id : String, params)
        body = HTTP::Params.new({
          "type"       => [TYPE],
          "account_id" => [account_id],
        })

        params.each_key do |key|
          body.add("params[#{key}]", params[key])
        end

        body
      end
    end
  end
end
