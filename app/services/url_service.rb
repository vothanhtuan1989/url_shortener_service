module UrlService
  def valid_url?(url)
    uri = URI.parse(url)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end

  def encode_url(url)
    url.hash.to_s(36)[0..5]
  end
end