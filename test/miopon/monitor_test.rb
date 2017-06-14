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

  describe "use dalli client cases" do
    before do
      client = mock
      client.expects(:get).returns(nil)
      Dalli::Client.stubs(:new).returns(client)
    end

    describe "#already_notified?" do
      it "should return false" do
        monitor = Miopon::Monitor.new
        monitor.already_notified?("xxx").must_equal false
      end
    end

    describe "#notify" do
      it "should push note by using Pushbullet API" do
        monitor = Miopon::Monitor.new
        line = Struct.new(:code, :with_coupon).new("hoge", 301)

        VCR.use_cassette("pushbullet_push_note") do
          push = monitor.notify line
          push.type.must_equal "note"
          push.body["title"].must_equal "A notice from Be Moderate"
          push.body["body"].must_equal "hoge uses 301MB today!"
        end
      end
    end
  end
end
