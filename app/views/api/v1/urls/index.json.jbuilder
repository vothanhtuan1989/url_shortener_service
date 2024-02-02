# frozen_string_literal: true

json.data do
  json.array! @urls do |url|
    json.partial! 'api/v1/urls/url', url:
  end
end
