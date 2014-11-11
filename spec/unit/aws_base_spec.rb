require File.expand_path('../../spec_helper', __FILE__)

describe Chef::Knife::AwsBase do
  before(:each) do
    @knife_aws_base = Chef::Knife::AwsBase.new
  end

  describe "connection" do
    it "raises a 'not implemented' error" do
      expect { @knife_aws_base.connection }.to raise_error(StandardError, /Abstract Method Not Implemented/)
    end
  end

  describe "locate_config_value" do
    before(:each) do
      Chef::Config[:knife][:test_key] = "test_value"
    end

    it "returns a matching value" do
      knife_config_value = @knife_aws_base.locate_config_value("test_key")
      expect(knife_config_value).to eq("test_value")
    end
  end

end