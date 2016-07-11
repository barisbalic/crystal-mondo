module Monzo
  class Client

    # Exposes methods for listing and manipulating `Card`s, which are not described in the official API docs at all.
    module Cards

      # Returns all `Card`s for the specified *account*.
      #
      # ```
      # account = client.accounts.first
      # client.cards(account) # => [#<Monzo::Card:0x10e6266c0 @id="card_CARDID", @processor_token="666", @processor="gps", @account_id="acc_ACCOUNTID", @last_digits="0666", @name="Baris Balic", @expires="11/2018", @status="ACTIVE", @created="2015-11-30T22:02:12.067Z">]
      # ```
      def cards(account : Account)
        cards(account.id)
      end

      # Returns all `Card`s for the specified *account_id*.
      def cards(account_id : String)
        response = get("/card/list?account_id=#{account_id}")
        Array(Monzo::Card).from_json(response, root: "cards")
      end

      # Freezes the specified `Card` so that it cannot be used to make purchases.
      # Returns `true` when successful.
      #
      # ```
      # account = client.accounts.first
      # card = client.cards(account).first
      # client.freeze(card) # => true
      # ```
      def freeze(card : Card)
        freeze(card.id)
      end

      # Freezes a `Card` with the specified *card_id*.
      def freeze(card_id : String)
        body = HTTP::Params.build do |query|
          query.add("card_id", card_id)
          query.add("status", Card::INACTIVE)
        end

        response = put("/card/toggle", body)
        true
      end

      # Unfreezes the specified `Card` so that it can be used to make purchases again.
      # Returns `true` when successful.
      #
      # ```
      # account = client.accounts.first
      # card = client.cards(account).first
      # client.unfreeze(card) # => true
      # ```
      def unfreeze(card : Card)
        unfreeze(card.id)
      end

      # Unfreezes a `Card` with the specified *card_id*.
      def unfreeze(card_id : String)
        body = HTTP::Params.build do |query|
          query.add("card_id", card_id)
          query.add("status", Card::ACTIVE)
        end

        response = put("/card/toggle", body)
        true
      end
    end
  end
end
