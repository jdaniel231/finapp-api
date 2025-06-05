class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  respond_to :json

  before_action :authenticate_user!

  private

  # Garante que Devise mostre JSON em vez de redirecionar (comportamento padrão)
  def authenticate_user!
    unless user_signed_in?
      render json: { error: "You need to sign in or sign up before continuing." }, status: :unauthorized
    end
  end
end
