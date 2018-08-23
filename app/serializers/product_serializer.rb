class ProductSerializer < ActiveModel::Serializer
  attributes :id, :lang, :image, :nutrition, :created_at, :updated_at, :user_id, :meta
  belongs_to :category

  def created_at
    object.created_at#.to_i
  end

  def updated_at
    object.updated_at#.to_i
  end

  def meta
     #if current_user && object.meta
       object.meta ||= {}
       object.meta[:created_at] = object.created_at.to_i
       object.meta[:updated_at] = object.updated_at.to_i
       object.meta
     #end
  end
end
