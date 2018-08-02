require 'rails_helper'

RSpec.describe TranslatesController, type: :controller do

  describe "GET #translate" do
    it "returns http success" do
      get :translate
      expect(response).to have_http_status(:success)
    end
  end

end
