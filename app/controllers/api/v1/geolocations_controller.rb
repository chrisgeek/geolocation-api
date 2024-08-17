module Api
  module V1
    class GeolocationsController < ApplicationController
      before_action :set_geolocation, only: %i[show create destroy]
      before_action :set_ip

      def show
        if @geolocation
          success_response(@geolocation, GeolocationSerializer)
        else
          failure_response(not_found_message, :not_found)
        end
      end

      def create
        return render json: { info: "Geolocation already exists #{@geolocation.ip}" } unless @geolocation.nil?
        return render json: { error: 'Invalid input' }, status: :unprocessable_entity if @ip.nil?

        address_type = AddressChecker.call(@ip)

        if address_type == :invalid_address
          render json: { error: "Invalid Address #{@ip}" }, status: :unprocessable_entity
        else
          res = RetrieveAndSaveIp.call(@ip, address_type)
          render json: { output: res }
        end
      end

      def destroy
        if @geolocation
          @geolocation.destroy!
          render json: 'Geolocation deleted successfully', status: :ok
        else
          failure_response(not_found_message, :not_found)
        end
      end

      private

      def set_geolocation
        @geolocation = Geolocation.find_by(ip: params[:geolocation][:ip])
      end

      def set_ip
        @ip = params[:geolocation][:ip]&.strip
      end

      def not_found_message
        'Geolocation Not found'
      end
    end
  end
end
