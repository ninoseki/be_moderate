require 'yaml'
require 'zlib'
require 'stringio'

def gunzip(data)
  io = StringIO.new(data, "rb")
  gz = Zlib::GzipReader.new(io)
  gz.read
end

data = YAML.load File.read("test/fixtures/vcr_cassettes/packet_info.yml")
puts gunzip(data["http_interactions"].first["response"]["body"]["string"])
