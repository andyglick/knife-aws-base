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

      def validate!(keys=[:aws_access_key_id, :aws_secret_access_key])
        errors = []

        unless Chef::Config[:knife][:aws_credential_file].nil?
          unless (Chef::Config[:knife].keys & [:aws_access_key_id, :aws_secret_access_key]).empty?
            errors << "Either provide a credentials file or the access key and secret keys but not both."
          end
          # File format:
          # AWSAccessKeyId=somethingsomethingdarkside
          # AWSSecretKey=somethingsomethingcomplete
          #               OR
          # aws_access_key_id = somethingsomethingdarkside
          # aws_secret_access_key = somethingsomethingdarkside

          aws_creds = []
          File.read(Chef::Config[:knife][:aws_credential_file]).each_line do | line |
            aws_creds << line.split("=").map(&:strip) if line.include?("=")
          end
          entries = Hash[*aws_creds.flatten]
          Chef::Config[:knife][:aws_access_key_id] = entries['AWSAccessKeyId'] || entries['aws_access_key_id']
          Chef::Config[:knife][:aws_secret_access_key] = entries['AWSSecretKey'] || entries['aws_secret_access_key']
        end

        keys.each do |k|
          pretty_key = k.to_s.gsub(/_/, ' ').gsub(/\w+/){ |w| (w =~ /(ssh)|(aws)/i) ? w.upcase  : w.capitalize }
          if Chef::Config[:knife][k].nil?
            errors << "You did not provide a valid '#{pretty_key}' value."
          end
        end

        if errors.each{|e| ui.error(e)}.any?
          exit 1
        end
      end

    end
  end
end