module Monzo
  class Attachment
    JSON.mapping({
      id:          String,
      user_id:     String,
      external_id: String,
      file_type:   String,
      file_url:    String,
      created:     String,
    })
  end
end
