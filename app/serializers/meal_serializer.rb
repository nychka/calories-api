class MealSerializer < ActiveModel::Serializer
  attributes :id, :product_id, :weight, :created_at

  def created_at
    object.created_at.to_i
  end
end
