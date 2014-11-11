require 'chef/knife'

class Chef
  class Knife
    class AwsBase < Knife

      def self.included(includer)
        includer.class_eval do

          deps do
            require 'fog'
            require 'readline'
            require 'chef/json_compat'
          end

          option :aws_credential_file,
                 :long => "--aws-credential-file FILE",
                 :description => "File containing AWS credentials as used by aws cmdline tools",
                 :proc => Proc.new { |key| Chef::Config[:knife][:aws_credential_file] = key }

          option :aws_access_key_id,
                 :short => "-A ID",
                 :long => "--aws-access-key-id KEY",
                 :description => "Your AWS Access Key ID",
                 :proc => Proc.new { |key| Chef::Config[:knife][:aws_access_key_id] = key }

          option :aws_secret_access_key,
                 :short => "-K SECRET",
                 :long => "--aws-secret-access-key SECRET",
                 :description => "Your AWS API Secret Access Key",
                 :proc => Proc.new { |key| Chef::Config[:knife][:aws_secret_access_key] = key }

          option :region,
                 :long => "--region REGION",
                 :description => "Your AWS region",
                 :proc => Proc.new { |key| Chef::Config[:knife][:region] = key }
        end
      end

      def connection
        raise StandardError, "Abstract Method Not Implemented: 'connection'"
      end


      def locate_config_value(key)
        key = key.to_sym
        config[key] || Chef::Config[:knife][key]
      end

      def msg_pair(label, value, color=:cyan)
        if value && !value.to_s.empty?
          puts "#{ui.color(label, color)}: #{value}"
        end
      end

    end
  end
end