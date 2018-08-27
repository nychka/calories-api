require 'rails_helper'

describe Authentication do

  it 'valid with same email and different provider' do
    auth = FactoryBot.create(:authentication, provider: 'facebook')

    expect {
      FactoryBot.create(:authentication, email: auth.email, provider: 'google')
    }.to change(Authentication, :count).by(1)
  end

  it 'must be unique in scope email and provider' do
    auth = FactoryBot.create(:authentication)

    expect {
      FactoryBot.create(:authentication, email: auth.email, provider: auth.provider)
    }.to raise_error(ActiveRecord::RecordInvalid)
  end


end
