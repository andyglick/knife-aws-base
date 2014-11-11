$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'chef'
require 'chef/knife/aws_base'

RSpec.configure do |conf|
  conf.before(:each) do
    Chef::Config.reset
    Chef::Config[:knife] ={}
  end
end