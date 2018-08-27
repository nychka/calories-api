class Authentication < ApplicationRecord
  belongs_to :user

  validates_uniqueness_of :email, scope: :provider
end
