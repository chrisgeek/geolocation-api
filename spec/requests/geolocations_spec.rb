require 'rails_helper'

RSpec.describe "Geolocations", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/geolocations/show"
      expect(response).to have_http_status(:success)
    end
  end

end
