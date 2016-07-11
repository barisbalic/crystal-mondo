module Monzo
  class Client

    # Exposes methods for dealing with and manipulating `Webhook`s as defined by the
    # [Webhooks API documentation](https://monzo.com/docs/#webhooks).
    module Webhooks

      # Returns the `Webhook`s for the specified *account*.
      #
      # ```
      # account = client.accounts.first
      # client.webooks(account) # => #<Monzo::Webhook:0x10c10db70 @id="webhook_WEBHOOKID", @account_id="acc_ACCOUNTID", @url="https://localhost">
      # ```
      def webhooks(account : Monzo::Account)
        webhooks(account.id)
      end

      # Returns `Webhook`s for the specified *account_id*.
      def webhooks(account_id : String)
        response = get("/webhooks?account_id=#{account_id}")
        Array(Monzo::Webhook).from_json(response, root: "webhooks")
      end

      # Registers a `Webhook` for the specified *account*, to `url`.
      #
      # ```
      # account = client.accounts.first
      # client.register(account, "https://localhost") # => #<Monzo::Webhook:0x10c10db70 @id="webhook_WEBHOOKID", @account_id="acc_ACCOUNTID", @url="https://localhost">
      # ```
      def register_webhook(account : Monzo::Account, url : String)
        register_webhook(account.id, url)
      end

      # Registers a `Webhook` for the specified *account_id*, to `url`.
      def register_webhook(account_id : String, url : String)
        params = HTTP::Params.build do |query|
          query.add("account_id", account_id)
          query.add("url", url)
        end
        response = post("/webhooks", params)

        Monzo::Webhook.from_json(response, root: "webhook")
      end

      # Deletes the specified `Webhook`.
      # Returns `true` when successful.
      #
      # ```
      # account = client.accounts.first
      # webhook = client.webhooks(account)
      # client.delete(webhook) # => true
      # ```
      def delete_webhook(webhook : Monzo::Webhook)
        delete_webhook(webhook.id)
      end

      # Deletes a `Webhook` with the specified *webhook_id*.
      def delete_webhook(webhook_id : String)
        response = delete("/webhooks/#{webhook_id}")
        true
      end
    end
  end
end
