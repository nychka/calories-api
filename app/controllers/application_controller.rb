class ApplicationController < ActionController::API
  before_action :authenticate_user!, except: [:index, :show]
end
