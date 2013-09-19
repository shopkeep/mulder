require 'mulder'

module Mulder
  class Capistrano

    def initialize(config_file, application, environment)
      config       = ::Mulder::Config.from(:yaml, file: config_file)
      @connection  = ::Mulder::Connection.new(config)
      @application = application
      @environment = environment
    end

    def client(role)
      @client ||= ::Mulder::Client.new(@connection, @application, @environment, role)
    end

    def ips(role, use_private = false)
      type_of_ips = use_private ? :private_ip_address : :public_ip_address

      client(role).instances.collect(&type_of_ips).compact
    end
  end
end