class Product < ApplicationRecord
  store_accessor :lang
  store_accessor :nutrition
  belongs_to :category
end