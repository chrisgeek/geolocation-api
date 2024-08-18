module Auth
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user
  end

  def authenticate_user
    token = extract_token_from_header
    if token.nil?
      render json: { error: 'Invalid token, please login' }, status: :unauthorized
      return
    end
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      decoded = decode(header)
      @current_user = User.find(decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :unprocessable_entity
    rescue JWT::DecodeError => e
      render json: { error: e.message }, status: :unprocessable_entity
    rescue JWT::ExpiredSignature
      render json: { error: 'Token has expired' }, status: :unauthorized
    end
  end
end
