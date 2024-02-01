class ShortenUrlCommand
  prepend SimpleCommand
  include UrlService

  def initialize(current_user:, original:)
    @current_user = current_user
    @original = original
  end

  def call
    if valid_url?(original)
      short = encode_url(original)
      url = current_user.urls.create!(
        original: original, short: short
      )
    else
      errors.add(:error, 'Invilid URL')
      return false
    end
  end

  private

  attr_reader :original, :current_user
end