require 'thor'

module Mulder
  class CLI < Thor

    desc "search APP ENV ROLE FORMAT CONFIG_FILE", "Search AutoScaling Groups for APP, ENV, ROLE, FORMAT and CONFIG_FILE"
    def search(app, env, role, format = 'human', config_file = 'config/aws.yml')
      Mulder.search(app, env, role, format, config_file)
    end

  end
end