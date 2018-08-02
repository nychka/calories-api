class Category < ApplicationRecord
  store_accessor :lang
  has_many :products
  paginates_per 20

  default_scope { order(created_at: :desc) }
  scope :max_count, ->(max) { limit(max) unless max.nil? }

  class << self
    def filter(params)
      if params[:page].present?
        page(params[:page])
      else
        max_count(params[:limit])
      end
    end
  end
end
