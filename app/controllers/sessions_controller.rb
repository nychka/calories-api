class SessionsController < Devise::SessionsController
  respond_to :json

  def create
    if auth = Authentication.find_by(email: email, provider: auth_params[:provider])
      user = auth.user
    else
      user = User.find_or_create_by! email: email, avatar: avatar
      user.authentications.create(email: email, provider: auth_params[:provider], access_token: token)
    end

    self.resource = user
    sign_in(:user, resource)

    respond_with resource
  end

  private

  def auth_params
    params.permit(:token, :provider, :grant_type)
  end

  def provider
    @provider ||= auth_params[:provider].camelize.constantize
  end

  def token
    auth_params[:token]
  end

  def avatar
    user_info[:avatar]
  end

  def email
    @email ||= user_info[:email]
  end

  def user_info
    @user_info ||= provider.get_info(token, grant_type)
  end

  def grant_type
    auth_params[:grant_type]
  end

  def respond_with(resource, _opts = {})
    render json: resource, status: :created
  end

  def respond_to_on_destroy
    head :no_content
  end
end