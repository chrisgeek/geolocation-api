# frozen_string_literal: true

require 'rails_helper'
require 'feature_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'POST /api/v1/login' do
    let!(:user) { create(:user, password: 'password123') }
    let(:valid_params) { { user: { email: user.email, password: 'password123' } } }
    let(:invalid_params) { { user: { email: user.email, password: 'invalid_password' } } }

    it 'returns a token and email with valid credentials' do
      post '/api/v1/users/login', params: valid_params

      expect(response).to have_http_status(:ok)
      expect(parsed_response['token']).to be_present
      expect(parsed_response['email']).to eq(user.email)
    end

    it 'returns an error with invalid credentials' do
      post '/api/v1/users/login', params: invalid_params

      expect(response).to have_http_status(:not_found)
      expect(parsed_response['error']).to eq('Invalid login details, try again')
    end
  end
end
