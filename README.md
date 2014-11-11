# Knife::AwsBase     [![travis ci status](https://travis-ci.org/brettcave/knife-aws-base.svg?branch=master)](https://travis-ci.org/brettcave/knife-aws-base)

Library for common properties used by knife aws plugins (e.g. knife-ec2, knife-s3, knife-elb and knife-cfn)

## Installation

Add this line to your application's Gemfile:

    gem 'knife-aws-base'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install knife-aws-base

## Usage

Create a base module for your plugin that includes AwsBase:

    require 'chef/knife'
    require 'chef/knife/aws_base'

    class Chef
      class Knife
        module ServiceBase

          def self.included(includer)
            includer.class_eval do
              include AwsBase

              def connection
                @connection ||= begin
                  connection = Fog::AWS::ServiceBase.new()
                end
              end
            end
          end
        end
      end
    end

Create classes

    require 'chef/knife'
    require 'chef/knife/service_base'

    class Chef
      class Knife
        class ServiceCreate < Chef::Knife::ServiceBase
        end
      end
    end



## Contributing

1. Fork it ( http://github.com/brettcave/knife-aws-base/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
