require_relative "../spec_helper"

describe "Miopon::Utils" do
  describe "#with_error_notify" do
    include Miopon::Utils
    it "should call Rollbar.error when an exception is thrown" do
      Rollbar.stubs(:error).returns "Rollbar.error has called"

      res = with_error_notify do
        raise RestClient::ExceptionWithResponse, "hoge"
      end
      expect(res).to eq("Rollbar.error has called")
    end
  end
end
