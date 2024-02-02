# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { "test@abc.com" }
    password { "qWZ*6uAg25H8!4" }
    root_user { false }
  end
end
