class Product < ApplicationRecord
  belongs_to :user, required: false
  store_accessor :lang
  store_accessor :nutrition
  belongs_to :category, required: false
  paginates_per 20

  default_scope { order(created_at: :desc) }
  scope :max_count, ->(max) { limit(max) unless max.nil? }
  scope :general, -> { where(user_id: nil)}

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