class ErrorHandler
  class << self
    def error_response(response)
      error_message = "HTTP request failed with status code: #{response.code}"
      error_message += "\nResponse body: #{response.body}" if response.body
      raise HttpError.new(error_message, response)
    end

    def connection_error(error)
      raise ConnectionError, "Failed to connect to the server: #{error.message}"
    end

    def timeout_error(error)
      raise TimeoutError, "Request timed out: #{error.message}"
    end

    def unexpected_error(error)
      raise UnexpectedError, "An unexpected error occurred: #{error.message}"
    end
  end

  class HttpError < StandardError
    attr_reader :response

    def initialize(message, response)
      super(message)
      @response = response
    end
  end

  class ConnectionError < StandardError; end
  class TimeoutError < StandardError; end
  class UnexpectedError < StandardError; end
end
