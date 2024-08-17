module HttpProvider
  class Factory
    class << self
      def register(id, provider)
        providers[id.to_sym] = provider
      end

      def provider(id = nil)
        id ? providers[id.to_sym] : providers.values.first
      end

      private

      def providers
        @providers ||= { net_http: HttpProvider::NetHttpProvider }
      end
    end
  end
end
