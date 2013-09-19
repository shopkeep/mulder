# Poirot

A deploy-time helper for your AWS AutoScaling groups, and servers. Discover the IP addresses of your instances by AutoScalingGroup.

## Installation

Add this line to your application's Gemfile:

    gem 'poirot'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install poirot

## Usage

### Capistrano

At the top of your `deploy.rb` file, add:

    require 'poirot/capistrano'

Configure some variables for later use:

    set :application, 'banana_sandwich'
    set :environment, 'production'
    set :aws_creds,   '/foo/config/aws.yml'
    set :poirot,      { Poirot::Capistrano.new(aws_creds, environment, application) }

Setting up your `worker` role:

    role :worker, *poirot.ips('WorkerServerGroup')

And your `app` role:

    role(:app, *poirot.ips('AppServerGroup')

And your `web` role:

    role :web, *poirot.ips('WebServerGroup')

And your `db` role:

    role :db, poirot.ips('WorkerServerGroup').first, primary: true

You can ask for private IPs as well:

    role :app, *poirot.ips('WorkerServerGroup', true)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
