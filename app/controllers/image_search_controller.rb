class ImageSearchController < ApplicationController
  def search
    response = find_images(params[:q])
    render json: response, status: :ok
  end

  private

  def provider
    Faraday.new(:url => 'https://api.cognitive.microsoft.com') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger, ::Logger.new(STDOUT), bodies: true
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      faraday.headers['Ocp-Apim-Subscription-Key'] = '2df90403b85d48a38526bd0cc611c860'
    end
  end

  def find_images(product_title)
    provider.get('/bing/v7.0/images/search', { q: product_title }).body
  end
end
