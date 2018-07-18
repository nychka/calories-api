class Category < ApplicationRecord
  store_accessor :lang
  has_many :products
end
