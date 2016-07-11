module Monzo
  class Client

    # Exposes the method for retrieving `Identity`, described in the documentation as `who_am_i`.
    module Identity
      # Fetches the `Identity` for the autenticated user.
      #
      # ```
      # client = Monzo.new("API_TOKEN")
      # client.who_am_i # => #<Monzo::Identity:0x102d40640 @authenticated=true, @client_id="oauthclient_CLIENTID", ...>
      # ```
      def identity
        response = get("/ping/whoami")
        Monzo::Identity.from_json(response)
      end
    end
  end
end
