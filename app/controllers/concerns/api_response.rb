# frozen_string_literal: true

module ApiResponse
  def failure_response(message, status = :unprocessable_entity)
    render json: { error:  message }, status: status
  end

  def success_response(data, serializer, res_status = :ok)
    render json: serializer.new(data).serialize, status: res_status
  end

  def not_found_message
    'Geolocation Not found'
  end

  def record_exists(klass, record_info)
    render json: { error: "#{klass} already exists for #{record_info}" }, status: :unprocessable_entity
  end

  def invalid_input(exception)
    render json: { error: "Invalid Input #{exception.message}" }, status: :unprocessable_entity
  end

  def socket_error(exception)
    render json: { error: exception.message }, status: 408
  end

  def parser_error(exception)
    render json: { error: exception.message }, status: :unprocessable_entity
  end

  def connection_error(exception)
    render json: { error: exception.message }
  end

  def timeout_error(exception)
    render json: { error: exception.message }
  end

  def record_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def unexpected_error(exception)
    render json: { error: exception.message }, status: :not_found
  end
end
