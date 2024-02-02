# frozen_string_literal: true

class Url < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search, against: [:original, :short], using: { tsearch: { prefix: true } }

  belongs_to :user

  validates :original,
            presence: true
end
