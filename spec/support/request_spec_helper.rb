module RequestSpecHelper

  include Warden::Test::Helpers

  def self.included(base)
    base.before(:each) { Warden.test_mode! }
    base.after(:each) { Warden.test_reset! }
  end

  def sign_in(resource)
    login_as(resource, scope: warden_scope(resource))
  end

  def sign_out(resource)
    logout(warden_scope(resource))
  end

  def json
    JSON.parse(response.body)
  end

  def collect_ids(collection)
    collection.map {|k| k['id'] }
  end

  private

  def warden_scope(resource)
    resource.class.name.underscore.to_sym
  end
end