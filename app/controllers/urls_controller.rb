class UrlsController < ApplicationController
  before_action :set_url, only: %i[ destroy ]

  # GET /urls or /urls.json
  def index
    page = params[:page] || 1
    @urls = current_user.urls.page(page).per(20)
  end

  # POST /urls or /urls.json
  def create
    cmd = ShortenUrlCommand.call(
      current_user: current_user,
      original: params[:url][:original]
    )

    respond_to do |format|
      if cmd.success?
        url = cmd.result
        format.turbo_stream do
          render turbo_stream: [
              turbo_stream.prepend(
                "list_urls",
                partial: "urls/url",
                locals: { url: url }
              ),
              turbo_stream.replace(
                "form_url",
                partial: "urls/form",
                locals: { url: Url.new }
              )
            ]
        end
      else
        format.turbo_stream do
          render turbo_stream: [
              turbo_stream.replace(
                "form_errors",
                html: cmd.errors[:error][0]
              )
            ]
        end
      end
    end
  end

  # DELETE /urls/1 or /urls/1.json
  def destroy
    @url.destroy!

    respond_to do |format|
      format.html { redirect_to urls_url, notice: "Url was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_url
      @url = Url.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def url_params
      params.require(:url).permit(:original, :short, :user_id)
    end
end
