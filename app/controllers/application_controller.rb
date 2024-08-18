class ApplicationController < ActionController::API
  include JwtToken
  include ApiResponse
  include Auth

  rescue_from JSON::ParserError, with: :parser_error
  rescue_from ErrorHandler::UnexpectedError, with: :unexpected_error
  rescue_from SocketError, with: :socket_error
  rescue_from Timeout::Error, with: :timeout_error
  rescue_from ErrorHandler::InvalidInput, with: :invalid_input
end
