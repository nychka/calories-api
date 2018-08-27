require 'rails_helper'

describe User do
  it 'has at least one authentication' do
    expect { FactoryBot.create(:user, with_auth: true ) }.to change(Authentication, :count).by(1)
  end

  it 'removes authentication after destroy' do
    user = FactoryBot.create(:user, with_auth: true)

    expect { user.destroy! }.to change(Authentication, :count).by(-1)
  end
end
