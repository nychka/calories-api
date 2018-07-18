class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    products = Product.all

    render json: products, each_serializer: ProductSerializer, status: 200
  end
end