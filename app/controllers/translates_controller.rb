class TranslatesController < ApplicationController
  def translate
    json_body = [{Text: params[:q]}].to_json
    length = json_body.length.to_s
    response = provider.post '/translate' do |request|
      request.params['api-version'] = '3.0'
      request.params['to'] = params['to'].gsub('ua', 'uk').split(',')
      request.params['from'] = params['from'].gsub('ua', 'uk')
      request.body = json_body
      request.headers['Content-Length'] = length
      request.headers['Ocp-Apim-Subscription-Key'] = 'bab7b248cbf3499882985908fe75aa83'
      request.headers['Content-Type'] = 'application/json'
    end

    render json: response.body.force_encoding('utf-8'), status: :ok
  end

  def provider
    Faraday.new(:url => 'https://api.cognitive.microsofttranslator.com') do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger, ::Logger.new(STDOUT), bodies: true
      faraday.adapter  Faraday.default_adapter
    end
  end
end
