# Mulder

A deploy-time helper for your AWS AutoScaling groups, and servers. Discover the IP addresses of your instances by AutoScalingGroup.

## Installation

Add this line to your application's Gemfile:

    gem 'mulder'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mulder

## Usage

### Capistrano

At the top of your `deploy.rb` file, add:

    require 'mulder/capistrano'

Configure some variables for later use:

    set :application, 'banana_sandwich'
    set :environment, 'production'
    set :aws_creds,   '/foo/config/aws.yml'
    set :mulder,      { Mulder::Capistrano.new(aws_creds, environment, application) }

Setting up your `worker` role:

    role :worker, *mulder.ips('WorkerServerGroup')

And your `app` role:

    role(:app, *mulder.ips('AppServerGroup')

And your `web` role:

    role :web, *mulder.ips('WebServerGroup')

And your `db` role:

    role :db, mulder.ips('WorkerServerGroup').first, primary: true

You can ask for private IPs as well:

    role :app, *mulder.ips('WorkerServerGroup', true)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
