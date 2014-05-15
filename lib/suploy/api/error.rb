module Suploy::Api::Error
  class SuployApiError < StandardError; end
  class ArgumentError < SuployApiError; end
  class ClientError < SuployApiError; end
  class UnauthorizedError < SuployApiError; end
  class NotFoundError < SuployApiError; end
  class ServerError < SuployApiError; end
  class UnexpectedResponseError < SuployApiError; end
  class TimeoutError < SuployApiError; end
  class AuthenticationError < SuployApiError; end
end
