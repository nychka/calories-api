class MealSerializer < ActiveModel::Serializer
  attributes :id, :product_id, :user_id, :weight, :created_at
end
