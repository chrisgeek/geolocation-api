module Api
  module V1
    class GeolocationsController < ApplicationController
      before_action :set_geolocation, only: %i[show  create destroy]

      def show
        if @geolocation
          render json: @geolocation
        else
          render json: { error: 'Geolocation not found' }, status: :not_found
        end
      end

      def create
        return render json: { info: "Geolocation already exists #{@geolocation.identifier}" } unless @geolocation.nil?

        # if url -> get the host -> call IPsocket to retrieve the ip address
        # if ip -> pass to the ipsocket receiver
        # make request to ip address provider
        # if res.success -> create geolocation
      end

      def destroy
        if @geolocation
          @geolocation.destroy!
          render json: "Geolocation deleted for #{params[:endpoint]}", status: :not_found
        else
          render json: { error: 'Geolocation not found' }, status: :not_found
        end
      end

      private

      def set_geolocation
        @geolocation = Geolocation.find_by(identifier: params[:geolocation][:identifier])
      end
    end
  end
end
