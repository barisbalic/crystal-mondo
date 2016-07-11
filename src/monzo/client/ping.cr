module Monzo
  class Client

    # Exposes the `ping` method, presumably for diagnostic purposes.
    module Ping

      # Fires a simple `ping` request at Monzo and returns `true` if successful.
      #
      # ```
      # client = Monzo.new("API_TOKEN")
      # client.ping # => true
      # ```
      def ping
        response = get("/ping")
        JSON.parse(response)["ping"].as_s == "pong"
      end
    end
  end
end
