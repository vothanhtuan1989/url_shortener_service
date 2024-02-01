class Api::V1::UrlsController < ApiController
  skip_before_action :authenticate, only: [:redirect]

  def index
    page = params[:page] || 1
    @urls = current_user.urls.page(page).per(20)

    render json: {urls: @urls}, status: :ok
  end

  def shorten
    if request.content_type == "application/json"
      cmd = ShortenUrlCommand.call(
        current_user: current_user,
        original: params[:original]
      )

      if cmd.success?
        url = cmd.result
        render json: {short: "http://localhost:3000/#{url.short}"}, status: :created
      else
        render json: {error: cmd.errors[:error]}, status: :bad_request
      end
    else
      render json: {error: "Unsupported content type"}, status: :unsupported_media_type
    end
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
end