require 'rails_helper'

describe 'Products' do
  let(:user){ FactoryBot.create(:user) }

  before(:each) do
    @products_ids = FactoryBot.create_list(:product, 5).pluck(:id)
  end

  context 'GET /products' do
    it 'gets general products only' do
      get '/products'

      expect(response.status).to be(200)
      expect(response_ids('products')).to match_array(@products_ids)
    end

    it 'gets general products with user\'s' do
      sign_in user
      user_products_ids = FactoryBot.create_list(:product, 3, user_id: user.id).pluck(:id)
      get '/products'

      expect(response.status).to be(200)
      expect(response_ids('products')).to match_array(@products_ids + user_products_ids)
    end
  end

  context 'POST /products' do
    before(:each) do
      @products = [
          { lang: { en: 'foo'}, nutrition: { calories: 111 }},
          { lang: { en: 'bar'}, nutrition: { calories: 222 }},
          { lang: { en: 'xyz'}, nutrition: { calories: 333 }}
      ]
    end

    it 'returns status 201' do
      sign_in user

      expect{ post '/products', params: { products: @products }}.to change{ Product.count }.by(3)
      expect(json['products'].length).to eq(3)
    end

    it 'returns status 401' do
      post '/products', params: { products: @products }

      expect(response.status).to be(401)
    end
  end

  context "DELETE /products" do
    before(:each) do
      @ids = FactoryBot.create_list(:product, 3, user_id: user.id).pluck(:id)
    end
    it "returns status 204" do
      sign_in user
      expect { delete '/products', params: { ids: @ids }}.to change{ Product.count }.by(-3)
    end

    it "returns status 401" do
      delete '/products', params: { ids: @ids }

      expect(response.status).to be(401)
    end
  end
end
