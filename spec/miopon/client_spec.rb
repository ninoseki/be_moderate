require_relative '../spec_helper'

vcr_options = { cassette_name: "log_packet" }

describe "Miopn::Cilent" do
  before do
    @client = Miopon::Client.new
  end

  describe "#check_packet_usages", vcr: vcr_options do
    it 'should return an array of Miopon::Line' do
      lines = @client.latest_packet_usages
      expect(lines.length).to be >= 0
      lines.each { |line| expect(line).to be_a(Miopon::Line) }
    end
  end
end
