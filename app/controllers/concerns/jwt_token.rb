# frozen_string_literal: true

require 'jwt'

module JwtToken
  SECRET_KEY = Rails.application.credentials.secret_key_base

  def encode(payload, exp: 3.days.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end

  def extract_token_from_header
    auth_header = request.headers['Authorization']
    return nil if auth_header.blank?

    auth_header.split(' ').last
  end
end
