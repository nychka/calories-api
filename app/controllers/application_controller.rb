class ApplicationController < ActionController::API
  before_action :authenticate_user!, except: [:index, :show]
  serialization_scope :current_user
end
