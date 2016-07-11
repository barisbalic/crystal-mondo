module Monzo
  class Client

    # Exposes methods for dealing with `Account` `Balance` as defined by the
    # [Balance API documentation](https://monzo.com/docs/#balance).
    module Balance

      # Fetches balance information for the specified *account*.
      #
      # ```
      # account = client.accounts.first
      # client.balance(account) # => #<Monzo::Balance:0x10bd82b70 @balance=12747, @currency="GBP", @spend_today=0>
      # ```
      def balance(account : Monzo::Account)
        balance(account.id)
      end

      # Returns a Balance object for the specified *account_id*.
      def balance(account_id : String)
        response = get("/balance?account_id=#{account_id}")
        Monzo::Balance.from_json(response)
      end
    end
  end
end
