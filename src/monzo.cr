require "http/client"
require "json"

require "./monzo/*"

# A client for the Monzo API
#
# ### General Usage
#
# ```
# require "monzo"
#
# client = Monzo.new("SATSUI-NO-HADOU")
# client.accounts.each do |account|
#   balance = client.balance(account)
#   puts balance.spend_today
# end
# ```
module Monzo

  def self.new(token : String)
    Client.new(token)
  end
end
