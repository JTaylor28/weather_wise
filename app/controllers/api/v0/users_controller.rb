class Api::V0::UsersController < ApplicationController
  before_action :check_for_nil_params, only: [:create]

  def create
    new_params = user_params
    new_params[:email] = new_params[:email].downcase
    new_user = User.new(email: new_params[:email], password: params[:password])  

    if new_user.save
      api_key = generate_api_key(new_user)
      new_user.update(api_key: api_key)
      render json: UsersSerializer.new(new_user), status: 201
    else
      render json: ErrorSerializer.new("invalid credentials").invalid_request, status: 404
    end
  end

  private

  def check_for_nil_params
    if params[:email].nil? || params[:password].nil? || params[:password_confirmation].nil? || params[:password] != params[:password_confirmation]
      render json: ErrorSerializer.new("invalid credentials").invalid_request, status: 404
    end
  end

  def generate_api_key(user)
    loop do
      api_key = SecureRandom.hex(16)
      break api_key unless User.exists?(api_key: api_key)
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end