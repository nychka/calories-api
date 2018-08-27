class SessionsController < Devise::SessionsController
  respond_to :json

  def create
    if auth = Authentication.find_by(email: email, provider: auth_params[:provider])
      user = auth.user
    else
      user = User.find_or_create_by! email: email
      user.authentications.create(email: email, provider: auth_params[:provider], access_token: access_token)
    end

    self.resource = user
    sign_in(:user, resource)

    respond_with resource
  end

  private

  def auth_params
    params.permit(:access_token, :provider)
  end

  def provider
    @provider ||= auth_params[:provider].camelize.constantize
  end

  def access_token
    auth_params[:access_token]
  end

  def email
    @email ||= user_info['email']
  end

  def user_info
    @user_info ||= provider.get_info(access_token)
  end

  def respond_with(resource, _opts = {})
    render json: resource, status: :created
  end

  def respond_to_on_destroy
    head :no_content
  end
end