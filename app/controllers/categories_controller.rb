class CategoriesController < ApplicationController
  def index
    categories = Category.filter(filter_params)
    meta =  {
        total: Category.count,
        totalPages: Category.page(filter_params[:page]).total_pages,
        perPage: Category.page(filter_params[:page]).limit_value,
        currentPage: Category.page(filter_params[:page]).current_page,
        nextPage: Category.page(filter_params[:page]).next_page,
        prevPage: Category.page(filter_params[:page]).prev_page
    }

    render json: categories, each_serializer: CategorySerializer, adapter: :json, meta: meta, status: 200
  end

  def update
    product = Category.find(params[:id])
    product.update!(category_params)

    render json: product.reload, status: 200
  end

  def create
    product = Category.new(category_params)

    if product.save
      render json: product, status: 201
    else
      render json: 'Unprocessible entity', status: 422
    end
  end

  def destroy
    product = Category.find(params[:id])

    if(product.destroy)
      head :no_content
    else
      render json: 'Category not found!', status: 404
    end
  end

  private

  def filter_params
    params.permit(:limit, :order, :page)
  end

  def category_params
    params.permit(:image, lang: params[:lang].keys)
  end
end
