# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    user = User.find_for_authentication(email: user_params['email'])

    if user &. valid_password?(user_params['password'])
      render json: user, status: 201
    else
      render json: 'User or password is not valid!', status: 401
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  protected

  def user_params
    params.permit(:email, :password)
  end
end
