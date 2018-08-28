require 'rails_helper'

describe 'Products' do

  describe 'GET /products/my' do

    it 'gets user products' do
      sign_in @user = FactoryBot.create(:user)
      products_ids = FactoryBot.create_list(:product, 3, user: @user).pluck(:id)

      get '/products/my'

      expect(response.status).to be(200)
      expect(collect_ids(json['products'])).to match_array(products_ids)
    end

    it 'gets unauthorized response' do
      get '/products/my'

      expect(response.status).to be(401)
    end
  end

  describe 'DELETE /products/:id' do
    context 'user' do
      it 'deletes own product' do
        sign_in @user = FactoryBot.create(:user)
        product = FactoryBot.create(:product, user: @user)

        delete "/products/#{product.id}"

        expect(response.status).to be(204)
      end

      it 'deletes other product' do
        sign_in @user = FactoryBot.create(:user)
        product = FactoryBot.create(:product, user: FactoryBot.create(:user))

        delete "/products/#{product.id}"

        expect(response.status).to be(404)
      end
    end
  end
end
