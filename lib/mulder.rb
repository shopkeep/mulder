module Mulder

  require_relative 'mulder/cli'
  require_relative 'mulder/client'
  require_relative 'mulder/config'
  require_relative 'mulder/connection'
  require_relative 'mulder/formatter'
  require_relative 'mulder/instance'
  require_relative 'mulder/version'

  def self.search(app, env, role, format, config_file)
    config     = Mulder::Config.from(:yaml, file: config_file)
    connection = Mulder::Connection.new(config)
    client     = Mulder::Client.new(connection, app, env, role)
    instances  = client.instances
    formatter  = Mulder::Formatter.new(instances, format)

    formatter.output
  end
end