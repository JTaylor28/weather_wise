class Api::V0::SessionsController < ApplicationController
  def create
    user = User.find_by(email: session_params[:email].downcase)

    if user && user.authenticate(session_params[:password])
      render json: LoginSerializer.new.login_success(user), status: 200
    else
      render json: ErrorSerializer.new("invalid credentials").bad_credentials, status: 401
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end