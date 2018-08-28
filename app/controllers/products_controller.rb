class ProductsController < ApplicationController

  def index
    products = Product.general.filter(filter_params)
    meta =  {
        total: Product.general.count,
        currentAmount: products.length,
        totalPages: Product.general.page(filter_params[:page]).total_pages,
        perPage: Product.general.page(filter_params[:page]).limit_value,
        currentPage: Product.general.page(filter_params[:page]).current_page,
        nextPage: Product.general.page(filter_params[:page]).next_page,
        prevPage: Product.general.page(filter_params[:page]).prev_page
    }

    render json: products, each_serializer: ProductSerializer, adapter: :json, meta: meta, status: 200
  end

  def my
    products = Product.where(user_id: current_user.id)
    meta = { total: products.length }

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
    products = products_params.map do |product_hash|
      product = Product.new(product_hash)
      product.user_id = current_user.id
      product.save!
      product
    end

    meta = { total: products.length }

    render json: products, each_serializer: ProductSerializer, adapter: :json, meta: meta, status: 201
  end

  def destroy
    product = Product.find_by(id: params[:id], user_id: current_user.id)
    if product&.destroy
      head :no_content
    else
      render json: { error: 'Product not found' }, status: 404
    end
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