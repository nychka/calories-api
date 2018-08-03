class Product < ApplicationRecord
  mount_uploader :image, ImageUploader
  store_accessor :lang
  store_accessor :nutrition
  belongs_to :category
  paginates_per 20

  default_scope { order(created_at: :desc) }
  scope :max, ->(max) { limit(max) unless max.nil? }

  class << self
    def filter(params)
      if params[:page].present?
        page(params[:page])
      else
        max(params[:limit])
      end
    end
  end
end