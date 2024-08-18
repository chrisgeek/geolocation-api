require 'rails_helper'
require 'feature_helper'

RSpec.describe 'Users', type: :request do
  let(:valid_params) { { user: { email: 'user@example.com', password: 'password' } } }
  let(:invalid_params) { { user: { email: nil, password: 'password' } } }

  describe 'POST #create' do
    context 'when the request is valid' do
      it 'creates a new user and returns a created status' do
        post '/api/v1/users', params: valid_params

        expect(response).to have_http_status(:created)
        expect(parsed_response['email']).to eq('user@example.com')
      end
    end

    context 'when the request is invalid' do
      it 'returns a failure message and unprocessable entity status' do
        post '/api/v1/users', params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed_response['error']).to include("Email can't be blank")
      end
    end
  end
end
