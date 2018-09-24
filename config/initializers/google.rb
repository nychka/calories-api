module Google
  client_id = ENV.fetch('CALORIES_CLIENT_ID', '930732790033-lirk2bn8esigr142rucgm86gqsifeum7.apps.googleusercontent.com')
  client_secret = ENV.fetch('CALORIES_CLIENT_SECRET', 'rQ_nmAjb6Vh7bUGLchlD2S4p')
  site = 'https://www.googleapis.com'

  @@client = OAuth2::Client.new(client_id, client_secret, site: site)

  class << self
    def get_info(token, grant_type)
      strategy = "#{grant_type}_strategy"
      self.send(strategy, token)
    end

    def id_token_strategy(id_token)
      response = JWT.decode(id_token, nil, false).first
    end

    def access_token_strategy(access_token)
      redirect_uri='http://localhost:3000/callback'
      token = OAuth2::AccessToken.new(@@client, access_token, redirect_uri: redirect_uri)
      response = token.get('userinfo/v2/me')
      structurize JSON.parse(response.body)
    end

    def structurize(data)
      {
          email: data['email'],
          avatar: data['picture']
      }
    end
  end
end
