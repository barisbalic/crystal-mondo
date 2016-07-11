module Monzo
  class Account
    JSON.mapping({
      id:          String,
      description: String,
      created:     String,
      # TODO
      #   sort_code
      #   account_number
      #   raw_data
    })
  end
end
