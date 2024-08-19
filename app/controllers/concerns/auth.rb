module Auth
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user
  end

  def authenticate_user
    token = extract_token_from_header
    if token.nil?
      render json: { error: "Invalid token, #{login_text}" }, status: :unauthorized
      return
    end
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      decoded = decode(header)
      @current_user = User.find(decoded[:user_id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: login_text }, status: :unauthorized
    rescue JWT::DecodeError
      render json: { error: login_text }, status: :unprocessable_entity
    rescue JWT::ExpiredSignature
      render json: { error: login_text }, status: :unauthorized
    end
  end

  def login_text
    'Please login or signup'
  end
end
