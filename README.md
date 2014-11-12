# Knife::AwsBase     [![travis ci status](https://travis-ci.org/brettcave/knife-aws-base.svg?branch=master)](https://travis-ci.org/brettcave/knife-aws-base)

Library for common properties used by knife aws plugins (e.g. knife-ec2, knife-s3, knife-elb and knife-cfn).

This module was developed as there was duplicate of xxx_base modules in the gems listed above, with all the modules having the same parameter code. Some modu;es

## Installation

Add this line to your application's Gemfile:

    gem 'knife-aws-base'

If you're not using Bundler or are using gemspec in Bundler, then add to your .gemspec:

    spec.add_dependency "knife-aws-base"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install knife-aws-base

## Usage

### Include AwsBase in your plugin and set up your connection (required: override abstract 'connection' method).

The example below sets up an AWS::ELB connection, and iterates through a list of ELBs in the run method:

    require 'chef/knife'
    require 'chef/knife/aws_base'

    class Chef
      class Knife
        class MypluginTest
          include AwsBase

          def connection
            @connection ||= begin
              connection = Fog::AWS::ELB.new(
                :aws_access_key_id => Chef::Config[:knife][:aws_access_key_id],
                :aws_secret_access_key => Chef::Config[:knife][:aws_secret_access_key],
                :region => locate_config_value(:region)
              )
            end
          end

          def run
            validate!

            connection.load_balancers.each do |elb|
              ui.info("Found load balancer with ID #{elb.id.to_s}")
            end
          end

        end
      end
    end

Now execute your plugin:

    bundle exec knife myplugin test -h

### AwsBase makes the following options / configs available:

- --aws-credential-file FILE - File containing AWS credentials as used by aws cmdline tools
- --aws-access-key-id ID
- --aws-secret-access-key SECRET
- --region

### The following methods are available:

`locate_config_value(key)` - returns the value from the `config` object (mixlib-config - e.g. command line parameters as per above) / knife configuration
`msg_pair(label,value)` - puts label/value. color can be provided as a 3rd parameter (e.g. `msg_pair("INFO","complete",:green)`
`validate!` - checks that valid / sufficient authentication configuration is available (credential file or access key id + secret access key).


## Contributing

1. Fork it ( http://github.com/brettcave/knife-aws-base/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
