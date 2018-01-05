require_relative "../spec_helper"

describe "Miopon::Monitor", vcr: { cassette_name: "log_packet" } do
  describe "#check_packet_usages" do
    it "should return violated lines only" do
      monitor = Miopon::Monitor.new
      lines = monitor.over_limit_lines
      expect(lines.length).to eq(1)
    end
  end

  describe "#stats" do
    it "should output packet usage of each line" do
      monitor = Miopon::Monitor.new
      expect(monitor.stats.length).to eq(5)
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
        expect(monitor.already_notified?("xxx")).to be_falsey
      end
    end

    describe "#notify" do
      it "should push note by using Pushbullet API" do
        monitor = Miopon::Monitor.new
        line = Struct.new(:code, :with_coupon).new("hoge", 301)

        VCR.use_cassette("pushbullet_push_note") do
          push = monitor.notify line
          expect(push.type).to eq("note")
          expect(push.body["title"]).to eq("A notice from Be Moderate")
          expect(push.body["body"]).to eq("hoge uses 301MB today!")
        end
      end
    end
  end
end
