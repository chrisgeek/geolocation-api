require 'rails_helper'

RSpec.describe UrlFormatter do
  describe '.extract_host' do
    it 'extracts the host from a full URL' do
      url = 'https://valid_url.com'
      expect(described_class.extract_host(url)).to eq('valid_url.com')
    end

    it 'extracts the host from a URL without a scheme' do
      url = 'valid_url.com'
      expect(described_class.extract_host(url)).to eq('valid_url.com')
    end

    it 'extracts the host from a URL with www' do
      url = 'http://www.valid_url.com'
      expect(described_class.extract_host(url)).to eq('www.valid_url.com')
    end

    it 'handles URLs with a path and query parameters' do
      url = 'https://valid_url.com/path?query=1'
      expect(described_class.extract_host(url)).to eq('valid_url.com')
    end

    it 'handles URLs with subdomains' do
      url = 'https://sub.valid_url.com'
      expect(described_class.extract_host(url)).to eq('sub.valid_url.com')
    end

    it 'handles uppercase letters in the URL' do
      url = 'HTTPS://VALID_URL.AI'
      expect(described_class.extract_host(url)).to eq('valid_url.ai')
    end

    it 'extracts the host from a URL with port number' do
      url = 'http://valid_url.com:8080'
      expect(described_class.extract_host(url)).to eq('valid_url.com')
    end
  end
end
