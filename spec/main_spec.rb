require 'spec_helper'

describe "Main" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it '/' do
    get '/'
    expect(last_response.body).to include("Be Moderate")
  end
end
