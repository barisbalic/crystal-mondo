module Monzo
  class TemporaryAttachmentData
    JSON.mapping({
      file_url: String,
      upload_url: String
    })
  end
end
