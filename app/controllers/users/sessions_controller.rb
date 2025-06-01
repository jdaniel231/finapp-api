class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    token = encode_token({ user_id: resource.id })

    render json: {
      status: { code: 200, message: "Logged in successfully." },
      data: UserSerializer.new(resource).serializable_hash[:data][:attributes].merge({ token: token })
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

  def encode_token(payload)
    JWT.encode(payload, Rails.application.secret_key_base)
  end
end
