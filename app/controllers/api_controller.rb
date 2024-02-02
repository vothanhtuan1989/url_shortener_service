# frozen_string_literal: true

class ApiController < ActionController::API
  acts_as_token_authentication_handler_for User, fallback: :none

  before_action :authenticate

  def authenticate
    return head(:unauthorized) unless current_user
  end
end
