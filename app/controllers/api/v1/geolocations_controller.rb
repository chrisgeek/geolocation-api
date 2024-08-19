module Api
  module V1
    class GeolocationsController < ApplicationController
      before_action :set_geolocation, only: %i[show create destroy]

      def show
        if @geolocation
          success_response(@geolocation, GeolocationSerializer)
        else
          failure_response(not_found_message, :not_found)
        end
      end

      def create
        return record_exists(Geolocation, geolocation_params[:ip]) unless @geolocation.nil?

        res = RetrieveAndSaveIp.call(@ip, @ip_type, HttpProvider::Factory.provider)
        render json: { output: res }
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

      def geolocation_params
        params.require(:geolocation).permit(:ip)
      end

      def set_geolocation
        ip = geolocation_params[:ip]&.strip
        @ip = formatted_address(ip)
        @ip_type = AddressChecker.call(ip)
        @geolocation = Geolocation.find_by(ip: @ip)
      end

      def formatted_address(ip_or_url)
        type = AddressChecker.call(ip_or_url)
        if type == :url
          url_host = UrlFormatter.extract_host(ip_or_url)
          UrlFormatter.convert_to_ip(url_host)
        elsif type == :invalid_address
          raise ErrorHandler::InvalidInput, ip_or_url
        else
          ip_or_url
        end
      end
    end
  end
end
