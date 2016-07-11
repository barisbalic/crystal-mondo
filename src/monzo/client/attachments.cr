module Monzo
  class Client

    # Exposes methods for dealing with and manipulating `Attachment`s as defined in the
    # [Attachments API documentation](https://monzo.com/docs/#attachments).
    #
    # `Attachment`s can be registered with a remote URL for their image content, but it is also possible to host that
    # image with `Monzo` directly, the full flow for doing so is as follows:
    # * Generate a temporary upload URL, which includes a `file_url`.
    # * Form-post the file to the upload URL.
    # * Register an `Attachment` with the `file_url` generated in the first step.
    #
    # **NOTE**: This client does not perform any upload on behalf of the user, as there is nothing special about posting
    # to the S3 bucket URL, choices regarding how to do so are left to the developer.
    module Attachments

      # Generates a `TemporaryAttachmentData` object.
      #
      # ```
      # data = client.upload_attachment("avatar.png", "image/png")
      # data # => #<Monzo::TemporaryAttachmentData:0x10e76f540 @file_url="...-avatar.png", @upload_url="...avatar.png">
      # ```
      def upload_attachment(filename : String, file_type : String)
        body = HTTP::Params.build do |query|
          query.add("file_name", filename)
          query.add("file_type", file_type)
        end

        response = post("/attachment/upload", body)
        Monzo::TemporaryAttachmentData.from_json(response)
      end

      # Registers an `Attachment` against the specified *transaction*.
      #
      # ```
      # account = client.accounts.first
      # transaction = client.transactions.first
      # attachment = client.register_attachment(transaction, "https://www.github.com/logo.png", "image/png")
      # attachment # => #<Monzo::Attachment:0x110bc9700 @id="attach_ATTACHMENTID", @user_id="user_USERID", ...>
      # ```
      def register_attachment(transaction : Monzo::Transaction, file_url : String, file_type : String)
        register_attachment(transaction.id, file_url, file_type)
      end

      # Registers an `Attachment` against the specified *transacion_id*.
      def register_attachment(transaction_id : String, file_url : String, file_type : String)
        body = HTTP::Params.build do |query|
          query.add("external_id", transaction_id)
          query.add("file_url", file_url)
          query.add("file_type", file_type)
        end

        response = post("/attachment/register", body)
        Monzo::Attachment.from_json(response, root: "attachment")
      end


      # Unregisters the specified *attachment*.
      #
      # ```
      # account = client.accounts.first
      # transaction = client.transactions(account)
      # attachment = transaction.attachments.first
      # client.deregister_attachment(attachment) # => true
      # ```
      def deregister_attachment(attachment : Monzo::Attachment)
        deregister_attachment(attachment.id)
      end

      # Unregisters an `Attachment` with the specified *attachment_id*.
      def deregister_attachment(attachment_id : String)
        body = HTTP::Params.build do |query|
          query.add("id", attachment_id)
        end

        response = post("/attachment/deregister", body)
        true
      end
    end
  end
end
