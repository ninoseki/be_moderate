require_relative "../test_helper"

describe "Miopon::Monitor" do
  before do
    @monitor = Miopon::Monitor.new
  end

  describe "#check_packet_usages" do
    it "should return violated lines only" do
      VCR.use_cassette("packet_info") do
        lines = @monitor.check_packet_usages
        lines.length.must_be :==, 1
      end
    end
  end
end
