class Api::V1::RegistrationsController < ApiController
  skip_before_action :authenticate, only: [:create]

  def create
    user = User.new(user_params)

    if user.save
      head(:created)
    else
      render json: {error: "Can not create user this time"}, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end