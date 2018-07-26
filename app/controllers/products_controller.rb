class ProductsController < ApplicationController
  #before_action :authenticate_user!

  def index
    products = Product.filter(filter_params)

    render json: products, each_serializer: ProductSerializer, status: 200
  end

  def show
    product = Product.find(params[:id])

    render json: product, status: 200
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

  def filter_params
    params.permit(:limit, :order, :page)
  end

  def product_params
    params.permit(:image, :category_id, lang: params[:lang].keys, nutrition: params[:nutrition].keys)
  end
end