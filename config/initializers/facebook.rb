module Facebook
  client_id = ENV.fetch('CALORIES_CLIENT_ID', '1816374385077661')
  client_secret = ENV.fetch('CALORIES_CLIENT_SECRET', '51dd631101bcb36d88a58be0aafd8217')
  site = 'https://graph.facebook.com'

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
      response = token.get('/me?fields=id,name,email,picture')
      structurize JSON.parse(response.body)
    end

    def structurize(data)
       {
           email: data['email'],
           avatar: data['picture']['data']['url']
       }
    end
  end
end
