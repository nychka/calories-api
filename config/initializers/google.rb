module Google
  client_id = ENV.fetch('CALORIES_CLIENT_ID', '930732790033-lirk2bn8esigr142rucgm86gqsifeum7.apps.googleusercontent.com')
  client_secret = ENV.fetch('CALORIES_CLIENT_SECRET', 'rQ_nmAjb6Vh7bUGLchlD2S4p')
  site = 'https://www.googleapis.com'

  @@client = OAuth2::Client.new(client_id, client_secret, site: site)

  def self.get_info access_token
    redirect_uri='http://localhost:3000/callback'
    token = OAuth2::AccessToken.new(@@client, access_token, redirect_uri: redirect_uri)
    response = token.get('userinfo/v2/me')
    JSON.parse(response.body)
  end
end
