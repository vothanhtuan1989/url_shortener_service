# frozen_string_literal: true

require 'digest'

module UrlService
  class << self
    def valid_url?(url)
      uri = URI.parse(url)
      uri.is_a?(URI::HTTP) && !uri.host.nil?
    rescue URI::InvalidURIError
      false
    end

    def encode_url(url)
      Digest::MD5.hexdigest(url).to_i(16).to_s(36)[0..5]
    end
  end
end
