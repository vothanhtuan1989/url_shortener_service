# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApiController
      skip_before_action :authenticate, only: [:create]

      def show
        head(:ok)
      end

      def create
        @user = User.find_by_email(params[:email])

        if @user&.valid_password?(params[:password])
          render :create, status: :created
        else
          head(:unauthorized)
        end
      end

      def destroy
        current_user.authentication_token = nil

        if current_user.save
          head(:ok)
        else
          head(:unauthorized)
        end
      end
    end
  end
end
