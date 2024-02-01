class ShortenUrlCommand
  prepend SimpleCommand

  def initialize(current_user:, original:)
    @current_user = current_user
    @original = original
  end

  def call
    return false unless valid_url?(original)

    short = encode_url(original)
    url = current_user.urls.create!(
      original: original, short: short
    )
  end

  private

  attr_reader :original, :current_user

  def valid_url?(url)
    # uri = URI.parse(url)
    # uri.is_a?(URI::HTTP) && !uri.host.nil? rescue URI::InvalidURIError
    # false
    true
  end

  def encode_url(url)
    url.hash.to_s(36)[0..5]
  end
end