class ShortenUrlCommand
  prepend SimpleCommand

  def initialize(current_user:, original:)
    @current_user = current_user
    @original = original
  end

  def call
    if UrlService.valid_url?(original)
      short = UrlService.encode_url(original)
      if Url.exists?(user_id: current_user.id, original: original)
        errors.add(:error, 'Existed URL')
        return false
      else
        url = current_user.urls.create!(
          original: original, short: short
        )
      end
    else
      errors.add(:error, 'Invilid URL')
      return false
    end
  end

  private

  attr_reader :original, :current_user
end