class ProductsController < ApplicationController

  def index
    products = Product.filter(filter_params)

    render json: products, each_serializer: ProductSerializer, status: 200
  end

  def show
    product = Product.find(params[:id])

    render json: product, status: 200
  end

  def update
    product = Product.find(params[:id])
    product.update!(product_params)

    render json: product.reload, status: 200
  end

  def create
    product = Product.new(product_params)
    product.category_id = 1

    if product.save!
      render json: product, status: 201
    else
      render json: 'Unprocessible entity', status: 422
    end
  end

  def destroy
    product = Product.find(params[:id])

    if(product.destroy)
      head :no_content
    else
      render json: 'Product not found!', status: 404
    end
  end

  private

  def filter_params
    params.permit(:limit, :order, :page)
  end

  def product_params
    params.permit(:image, lang: params[:lang].keys, nutrition: params[:nutrition].keys)
  end
end