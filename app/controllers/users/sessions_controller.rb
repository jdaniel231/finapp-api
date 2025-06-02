class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    token = request.env["warden-jwt_auth.token"] # Obtém o token JWT gerado pelo Devise JWT
    render json: {
      status: { code: 200, message: "Logged in successfully." },
      data: UserSerializer.new(resource).serializable_hash[:data][:attributes],
      authorization: token
    }, status: :ok
  end

  def respond_to_on_destroy
    if current_user
      render json: {
        status: 200,
        message: "Logged out successfully."
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
end
