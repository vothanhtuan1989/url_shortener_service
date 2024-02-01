class Api::V1::UrlsController < ApiController
  skip_before_action :authenticate, only: [:redirect]

  def shorten
    # if request.content_type == "application/json"
      original = params[:original]
      if valid_url?(original)
        short = encode_url(original)
        url = Url.create(original: original, short: short)
        render json: {short: "http://localhost:3000/#{url.short}"}, status: :created
      else
        render json: {error: "Invalid URL"}, status: :bad_request
      end
    # else
    #   render json: {error: "Unsupported content type"}, status: :unsupported_media_type
    # end
  end
  
  def redirect
    short = params[:short]
    url = Url.find_by(short: short)
    if url
      redirect_to url.original, allow_other_host: true
    else
      render json: {error: "Not found"}, status: :not_found
    end
  end
  
    private
  
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