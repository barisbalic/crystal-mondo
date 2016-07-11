module Monzo

  # Exposes errors documented in the [Error API documentation](https://monzo.com/docs/#errors).
  module Errors
    class Error < ::Exception; end

    class BadRequest < Error; end

    class Unauthorized < Error; end

    class Forbidden < Error; end

    class NotAcceptable < Error; end

    class NotFound < Error; end

    class MethodNotAllowed < Error; end

    class TooManyRequests < Error; end

    class InternalServiceError < Error; end

    class GatewayTimeout < Error; end
  end
end
