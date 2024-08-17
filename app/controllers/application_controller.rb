class ApplicationController < ActionController::API
  # rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from JSON::ParserError, with: :parser_error
  rescue_from ErrorHandler::UnexpectedError, with: :unexpected_error
  rescue_from SocketError, with: :socket_error
  rescue_from Timeout::Error, with: :timeout_error

  def failure_response(message, status = :unprocessable_entity)
    render json: { error:  message }, status: status
  end

  def success_response(data, klass, res_status = :ok)
    render json: klass.new(data).serialize, status: res_status
  end

  private

  def socket_error(exception)
    render json: { error: " #{exception.message} Request Timeout" }, status: 408
  end

  def parser_error(exception)
    render json: { error: exception.message }, status: :unprocessable_entity
  end

  def connection_error(exception)
    render json: { error: exception.message }
  end

  def timeout_error(exception)
    render json: { error: "#{exception.message} Request Timeout" }, status: 408
  end

  def record_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end
end
