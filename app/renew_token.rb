require 'uri'
AUTHORIZATION = "https://api.iijmio.jp/mobile/d/v1/authorization/"

params = {}
params["response_type"] = "token"
params["client_id"] = ENV["IIJMIO_DEVELOPER_ID"]
params["redirect_uri"] = "https://be-moderate.herokuapp.com/"
params["state"] = "hoge"

puts [ AUTHORIZATION, "?", URI.encode_www_form(params)].join
