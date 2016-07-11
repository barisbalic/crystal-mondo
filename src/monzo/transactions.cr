module Monzo
  class Transaction
    JSON.mapping({
      id:                   String,
      created:              String,
      description:          String,
      amount:               Int64,
      currency:             String,
      merchant:             {type: Monzo::Merchant, nilable: true},
      notes:                String,
      metadata:             JSON::Any,
      account_balance:      Int64,
      attachments:          {type: Array(Attachment), nilable: true},
      category:             String,
      is_load:              Bool,
      settled:              String,
      local_amount:         Int64,
      local_currency:       String,
      updated:              String,
      account_id:           String,
      counterparty:         JSON::Any,
      scheme:               String,
      dedupe_id:            String,
      originator:           Bool,
      include_in_spending:  Bool
    })
  end
end
