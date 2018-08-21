class ProductsController < ApplicationController

  def index
    products = Product.filter(filter_params)
    meta =  {
        total: Product.count,
        currentAmount: products.length,
        totalPages: Product.page(filter_params[:page]).total_pages,
        perPage: Product.page(filter_params[:page]).limit_value,
        currentPage: Product.page(filter_params[:page]).current_page,
        nextPage: Product.page(filter_params[:page]).next_page,
        prevPage: Product.page(filter_params[:page]).prev_page
    }

    render json: products, each_serializer: ProductSerializer, adapter: :json, meta: meta, status: 200
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

    if product.save
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
    params.permit(:image, :category_id, lang: params[:lang].keys, nutrition: params[:nutrition].keys)
  end
end