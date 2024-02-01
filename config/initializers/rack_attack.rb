class Rack::Attack
  # Allow 2-5 requests per second per IP
  throttle('req/ip', limit: 5, period: 1.second) do |req|
    # Return the IP address of the request
    req.ip
  end
  
  # Customize the response when a request is throttled
  self.throttled_response = ->(env) {
    # Get the retry after value from the headers
    retry_after = (env['rack.attack.match_data'] || {})[:period]
    # Set the status code to 429 (Too Many Requests)
    [ 429, 
      # Set the headers
      {
        'Content-Type' => 'application/json',
        'Retry-After' => retry_after.to_s
      },
      # Set the body to a JSON message
      [{ error: "Throttle limit reached. Retry later." }.to_json]
    ]
  }
end