require 'fog'

module Mulder
  class Connection

    attr_reader :config

    def initialize(config)
      @config = config
    end

    def group_by_id_regexp(id_regexp)
      autoscaler.groups.find_all do |group|
        group.id =~ id_regexp
      end.last
    end

    def instances_by_group(group)
      group.instances.collect do |instance|
        compute_instance = server_by_instance_id(instance.id)
        Mulder::Instance.new(compute_instance)
      end
    rescue
      []
    end

    def server_by_instance_id(instance_id)
      compute.servers.get(instance_id)
    end

    def autoscaler
      @autoscaler ||= ::Fog::AWS::AutoScaling.new(
        :aws_access_key_id => @config.aws_access_key_id,
        :aws_secret_access_key => @config.aws_secret_access_key
      )
    end

    def compute
      @compute ||= ::Fog::Compute::AWS.new(
        :aws_access_key_id => @config.aws_access_key_id,
        :aws_secret_access_key => @config.aws_secret_access_key
      )
    end

  end
end
