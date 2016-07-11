module Monzo
  class Card
    ACTIVE = "ACTIVE"
    INACTIVE = "INACTIVE"

    JSON.mapping({
      id:               String,
      processor_token:  String,
      processor:        String,
      account_id:       String,
      last_digits:      String,
      name:             String,
      expires:          String,
      status:           String,
      created:          String
    })
  end
end
