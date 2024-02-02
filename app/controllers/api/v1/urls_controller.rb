# frozen_string_literal: true

module Api
  module V1
    class UrlsController < ApiController
      skip_before_action :authenticate, only: [:redirect]

      before_action :set_url, only: %i[original_url redirect]

      def index
        page = params[:page] || 1
        @urls =
          current_user.urls
                      .page(page)
                      .per(20)

        render :index, status: :ok
      end

      def shorten
        if request.content_type == 'application/json'
          cmd = ShortenUrlCommand.call(
            current_user:,
            original: params[:original]
          )

          if cmd.success?
            url = cmd.result
            render json: { short: "#{ENV['BASE_URL']}/#{url.short}" },
                   status: :created
          else
            render json: { error: cmd.errors[:error] },
                   status: :bad_request
          end
        else
          render json: { error: 'Unsupported content type' },
                 status: :unsupported_media_type
        end
      end

      def original_url
        if @url.present?
          render json: { original: @url.original },
                 status: :ok
        else
          render json: { error: 'Not found' },
                 status: :not_found
        end
      end

      def redirect
        if @url.present?
          redirect_to @url.original,
                      allow_other_host: true
        else
          render json: { error: 'Not found' },
                 status: :not_found
        end
      end

      private

      def set_url
        short = params[:short]
        @url = Url.where(
          short:,
          user_id: current_user.id
        ).first
      end
    end
  end
end
