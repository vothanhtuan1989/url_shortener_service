json.data do
  json.array! @urls do |url|
    json.partial! 'api/v1/urls/url', url: url
  end
end