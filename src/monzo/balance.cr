module Monzo
  class Balance
    JSON.mapping({
      balance:              Int64,
      currency:             String,
      spend_today:          Int64,
      local_currency:       String,
      local_exchange_rate:  Int64
    })
  end
end
