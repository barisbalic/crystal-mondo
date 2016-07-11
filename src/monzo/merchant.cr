module Monzo
  class Merchant
    JSON.mapping({
      id:               String,
      group_id:         String,
      created:          String,
      name:             String,
      logo:             String,
      emoji:            String,
      category:         String,
      online:           Bool,
      atm:              Bool,
      address:          {type: Address, nilable: true},
      updated:          String,
      metadata:         JSON::Any,
      disable_feedback: Bool,
    })
  end
end
