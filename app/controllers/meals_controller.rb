class MealsController < ApplicationController
  before_action :authenticate_user!

  def index
    @meals = Meal.where(user_id: current_user.id)

    render json: @meals, each_serializer: MealSerializer, adapter: :json
  end

  def create
    meals = meals_params.map { |hash| create_by(hash) }

    render json: meals, each_serializer: MealSerializer, adapter: :json, status: :created
  end

  private

  def create_by(hash)
    meal = Meal.new(hash)
    meal.to_datetime = hash[:created_at]
    meal.user_id = current_user.id
    meal.save!
    meal
  end

  def meals_params
    params.require(:meals).map do |param|
      param.permit(:product_id, :user_id, :weight, :created_at)
    end
  end
end
