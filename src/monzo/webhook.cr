module Monzo
  class Webhook
    JSON.mapping({
      id:         String,
      account_id: String,
      url:        String,
    })
  end
end
