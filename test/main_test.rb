require 'test_helper'

describe "Main" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it '/' do
    get '/'
    last_response.body.must_include "Be Moderate"
  end
end
