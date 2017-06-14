require_relative "../test_helper"

describe "Miopon::Monitor" do
  describe "#check_packet_usages" do
    it "should return violated lines only" do
      monitor = Miopon::Monitor.new
      VCR.use_cassette("packet_info") do
        lines = monitor.check_packet_usages
        lines.length.must_be :==, 1
      end
    end
  end

  describe "#already_notified?" do
    before do
      client = mock
      client.expects(:get).returns(nil)
      Dalli::Client.stubs(:new).returns(client)
    end
    it "should return false" do
      monitor = Miopon::Monitor.new
      monitor.already_notified?("xxx").must_equal false
    end
  end
end
