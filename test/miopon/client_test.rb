require_relative '../test_helper'

describe "Miopn::Cilent" do
  before do
    @client = Miopon::Client.new
  end

  describe "#check_packet_usages" do
    it 'should return an array of Miopon::Line' do
      VCR.use_cassette("packet_info") do
        lines = @client.latest_packet_usages
        lines.length.must_be :>=, 0
        lines.each { |line| line.must_be_instance_of Miopon::Line }
      end
    end
  end
end
