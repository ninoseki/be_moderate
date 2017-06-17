require_relative "../test_helper"

describe "Miopon::Utils" do
  describe "#with_error_notify" do
    include Miopon::Utils
    it "should call Rollbar.error when an exception is thrown" do
      Rollbar.stubs(:error).returns "Rollbar.error has called"

      res = with_error_notify do
        raise StandardError, "hoge"
      end
      res.must_equal "Rollbar.error has called"
    end
  end
end
