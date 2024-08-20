module GeolocationProvider
  class Factory
    class << self
      def register(id, provider)
        providers[id.to_sym] = provider
      end

      def provider(id = nil)
        provider_class = id ? providers[id.to_sym] : providers.values.first
      end

      private

      def providers
        @providers ||= { ipstack: GeolocationProvider::Ipstack }
      end
    end
  end
end
