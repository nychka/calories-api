class ProductsController < ApplicationController
  #authenticate_user!

  def index
    products = Product.all

    render json: products, status: 200
  end
end