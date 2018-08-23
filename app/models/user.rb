class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :jwt_authenticatable,
         jwt_revocation_strategy: self
  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_many :products
end
