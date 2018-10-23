require 'rails_helper'

RSpec.describe "Meals", type: :request do
  let(:user){ FactoryBot.create(:user)}

  context "GET /meals" do
    let(:meals_count){ 3 }

    before(:each) do
      FactoryBot.create_list(:meal, 2)
      @meals_ids = FactoryBot.create_list(:meal, meals_count, user_id: user.id).pluck(:id)
    end

    it "returns status 200" do
      sign_in user
      get meals_path

      expect(response).to have_http_status(200)
    end

    it "gets only user's meals" do
      sign_in user
      get meals_path
      ids = response_ids('meals')

      expect(ids.count).to eq(meals_count)
      expect(ids).to eq(@meals_ids)
    end

    it "returns status 401" do
      get meals_path

      expect(response).to have_http_status(401)
    end
  end

  context "POST /meals" do
    before(:each) do
      products = FactoryBot.create_list(:product, 3)
      @meals = products.map do |product|
        { product_id: product.id, weight: 100, created_at: (DateTime.now - product.id).to_i }
      end
    end

    it "returns status 401" do
      post meals_path, params: { meals: @meals }

      expect(response.status).to be(401)
    end

    it "returns status 201" do
      sign_in user
      post meals_path, params: { meals: @meals }

      expect(response.status).to be(201)
    end

    it "creates with correct timestamps" do
      sign_in user
      post meals_path, params: { meals: @meals }

      expect(json['meals'].length).to eq(@meals.length)
      expect(unix_timestamps(json['meals'])).to match_array(@meals.pluck(:created_at))
    end
  end

  context "DELETE /meals" do
    before(:each) do
      FactoryBot.create_list(:meal, 3)
      @ids = FactoryBot.create_list(:meal, 5, user_id: user.id).pluck(:id)
    end
    it "returns status 204" do
      sign_in user
      expect { delete '/meals', params: { ids: @ids }}.to change{ Meal.count }.by(-5)
    end

    it "returns status 401" do
      delete '/meals', params: { ids: @ids }

      expect(response.status).to be(401)
    end
  end
end
