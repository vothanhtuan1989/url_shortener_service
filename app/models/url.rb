class Url < ApplicationRecord
  belongs_to :user

  validates :original,
            presence: true
end
