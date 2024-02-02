class Url < ApplicationRecord
  belongs_to :user

  validates :original_url, presence: true, format: %r{http(s)://.+}
end
