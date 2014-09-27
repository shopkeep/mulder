module Mulder
  class Client

    attr_reader :app, :role, :environment

    def initialize(connection, app, environment, role)
      @connection  = connection
      @app         = app
      @environment = environment
      @role        = role
    end

    def group
      @connection.group_by_id_regexp(id_regexp)
    end

    def instances
      @connection.instances_by_group(group)
    end

    def id_regexp
      /^#{@app}-#{@environment}-(.*-)?#{@role}-.*$/i
    end

  end
end
