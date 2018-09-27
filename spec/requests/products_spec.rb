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

  # describe 'DELETE /products/:id' do
  #   context 'user' do
  #     it 'deletes own product' do
  #       sign_in @user = FactoryBot.create(:user)
  #       product = FactoryBot.create(:product, user: @user)
  #
  #       delete "/products/#{product.id}"
  #
  #       expect(response.status).to be(204)
  #     end
  #
  #     it 'deletes other product' do
  #       sign_in @user = FactoryBot.create(:user)
  #       product = FactoryBot.create(:product, user: FactoryBot.create(:user))
  #
  #       delete "/products/#{product.id}"
  #
  #       expect(response.status).to be(404)
  #     end
  #   end
  # end
end
