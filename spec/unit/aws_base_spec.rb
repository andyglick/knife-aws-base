require File.expand_path('../../spec_helper', __FILE__)

describe Chef::Knife::AwsBase do
  before(:each) do
    @knife_aws_base = Object.new
    @knife_aws_base.extend(Chef::Knife::AwsBase)
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

  describe "validate!" do
    before(:each) do
      Chef::Config[:knife][:aws_access_key_id] = "test_access_key_id"
      Chef::Config[:knife][:aws_secret_access_key] = "test_secret_access_key"
    end

    it "verifies that an access key ID and secret access key is set" do
      expect {@knife_aws_base.validate!}
    end

  end

end
