require_relative '../spec_helper'

describe Miopon::Client do
  describe "#latest_packet_usages", vcr: { cassette_name: "log_packet" } do
    it 'should return an array of Miopon::Line' do
      lines = subject.latest_packet_usages
      expect(lines.length).to be >= 0
      lines.each { |line| expect(line).to be_a(Miopon::Line) }
    end
  end

  describe "#coupon", vcr: { cassette_name: "coupon" } do
    it "should return 200 response" do
      res = subject.coupon
      expect(res.code).to eq(200)
      json = JSON.parse(res.body)
      expect(json["returnCode"]).to eq("OK")
    end
  end
end
