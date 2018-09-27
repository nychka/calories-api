class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    if user_signed_in?
      products = Product.general.or(Product.where(user_id: current_user.id))
    else
      products = Product.general
    end

    render json: products, each_serializer: ProductSerializer, adapter: :json, status: 200
  end

  def create
    products = products_params.map do |product_hash|
      product = Product.new(product_hash)
      product.user_id = current_user.id
      product.save!
      product
    end

    meta = { total: products.length }

    render json: products, each_serializer: ProductSerializer, adapter: :json, meta: meta, status: 201
  end

  private

  def filter_params
    params.permit(:limit, :order, :page)
  end

  def products_params
    params.require(:products).map do |param|
      param.permit(:image, :category_id, nutrition: param[:nutrition].keys,
                   lang: param[:lang].keys, meta: param[:meta].keys)
    end
  end

  def product_params
    params.permit(:image, :category_id, nutrition: param[:nutrition].keys,
                     lang: param[:lang].keys, meta: param[:meta].keys)
  end
end