module Monzo
  class Address
    JSON.mapping({
      short_formatted: String,
      formatted:       String,
      address:         String,
      city:            String,
      region:          String,
      country:         String,
      postcode:        String,
      latitude:        Float64,
      longitude:       Float64,
      zoom_level:      Int32,
      approximate:     Bool,
    })
  end
end
