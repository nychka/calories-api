class ProductsController < ApplicationController
  #before_action :authenticate_user!

  def index
    products = Product.all

    render json: products, each_serializer: ProductSerializer, status: 200
  end

  def create
    product = Product.new(product_params)

    if product.save
      render json: product, status: 201
    else
      render json: 'Unprocessible entity', status: 422
    end
  end

  private

  def product_params
    params.permit(:image, :category_id, lang: params[:lang].keys, nutrition: params[:nutrition].keys)
  end
end