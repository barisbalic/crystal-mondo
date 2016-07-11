require "./client/accounts"
require "./client/attachments"
require "./client/balance"
require "./client/cards"
require "./client/feed_items"
require "./client/identity"
require "./client/ping"
require "./client/transactions"
require "./client/webhooks"
require "./client/errors"

module Monzo
  class Client
    include Monzo::Client::Accounts
    include Monzo::Client::Attachments
    include Monzo::Client::Balance
    include Monzo::Client::Cards
    include Monzo::Client::FeedItems
    include Monzo::Client::Identity
    include Monzo::Client::Ping
    include Monzo::Client::Transactions
    include Monzo::Client::Webhooks

    # :nodoc:
    def initialize(token : String)
      @token = token
      @http_client = HTTP::Client.new("api.monzo.com", tls: true)
    end

    private def error_check(response)
      client_error = "You should not see this error, please raise an issue on http://github.com/barisbalic/crystal-monzo."
      monzo_error = "Monzo may be expericing issues, you should check https://mondo.statuspage.io/."

      case response.status_code
      when 400
        invalid_param_error(response)
      when 401
        raise Errors::Unauthorized.new("Token invalid or expired.")
      when 403
        raise Errors::Forbidden.new("Your request is authenticated, but has insufficient permissions.")
      when 404
        raise Errors::NotFound.new("The requested endpoint could not be found. #{client_error}")
      when 405
        raise Errors::MethodNotAllowed.new("The request used an incorrect verb. #{client_error}")
      when 406
        raise Errors::NotAcceptable.new("Your application does not accept the content format. #{client_error}")
      when 429
        raise Errors::TooManyRequests.new("You are exceeding the request rate-limit, put some delay between requests.")
      when 500
        raise Errors::InternalServiceError.new("Monzo failed to process your request. #{monzo_error}")
      when 504
        raise Errors::GatewayTimeout.new("The request timedout. #{monzo_error}")
      end
    end

    private def invalid_param_error(response)
      error = JSON.parse(response.body)
      raise Errors::BadRequest.new(error["message"].to_s)
    end

    private def default_headers
      HTTP::Headers{"Authorization" => "Bearer #{@token}"}.add("User-Agent", "crystal-monzo version #{Monzo::VERSION}")
    end

    private def get(url)
      request("GET", url)
    end

    private def post(url, params)
      headers = default_headers.add("Content-Type", "application/x-www-form-urlencoded")
      request("POST", url, params, headers)
    end

    private def put(url, params)
      headers = default_headers.add("Content-Type", "application/x-www-form-urlencoded")
      request("PUT", url, params, headers)
    end

    private def patch(url, params)
      headers = default_headers.add("Content-Type", "application/x-www-form-urlencoded")
      request("PATCH", url, params, headers)
    end

    private def delete(url)
      request("DELETE", url)
    end

    private def request(method, url, params, headers)
      response = @http_client.exec(method, url, headers: headers, body: params.to_s)
      error_check(response)
      response.body
    end

    private def request(method, url)
      response = @http_client.exec(method, url, headers: default_headers)
      error_check(response)
      response.body
    end
  end
end
