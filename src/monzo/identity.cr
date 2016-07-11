module Monzo
  class Identity
    JSON.mapping({
      authenticated: Bool,
      client_id:     String,
      user_id:       String,
    })
  end
end
