class ProductSerializer < ActiveModel::Serializer
  attributes :id, :lang, :image, :created_at, :updated_at
  belongs_to :category

  def created_at
    object.created_at.to_i
  end

  def updated_at
    object.updated_at.to_i
  end
end
