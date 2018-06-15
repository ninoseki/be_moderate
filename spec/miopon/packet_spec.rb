require_relative '../spec_helper'
require 'yaml'

describe Miopon::PacketInfo do
  let(:packet_info) do
    path = File.expand_path("../fixtures/vcr_cassettes/log_packet.yml", __dir__)
    hash = YAML.load_file(path)
    string = hash["http_interactions"].first.dig("response", "body", "string").to_s
    Miopon::PacketInfo.new string
  end

  describe "#packet_log" do
    it "should return Array" do
      expect(packet_info.packet_log).to be_a Array
    end
  end

  describe "#latest_packet_usages" do
    it "should return Array of Line" do
      expect(packet_info.latest_packet_usages).to be_a Array
      packet_info.latest_packet_usages.each do |line|
        expect(line).to be_a Miopon::Line
        expect(line.code).to be_a String
        expect(line.date).to be_a String
        expect(line.with_coupon).to be_a Integer
      end
    end
  end
end
