module Monzo
  class Client

    # Exposes methods for dealing with `Account`s as defined by the
    # [Accounts API documentation](https://monzo.com/docs/#accounts).
    module Accounts

      # Returns alli `Account`s for the authenticated user.
      #
      # ```
      # client.accounts # => [#<Monzo::Account:0x10a4eaba0 @id="acc_MYACCOUNTID", @description="Baris Balic", @created="2016-01-18T10:51:04.056Z">]
      # ```
      def accounts
        response = get("/accounts")
        Array(Monzo::Account).from_json(response, root: "accounts")
      end
    end
  end
end
