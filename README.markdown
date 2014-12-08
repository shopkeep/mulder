# Mulder

A deploy-time helper for your AWS AutoScaling groups, and servers. Discover the IP addresses of your instances by AutoScalingGroup.

[![Build Status](https://travis-ci.org/shopkeep/mulder.png?branch=master)](https://travis-ci.org/shopkeep/mulder) [![Code Climate](https://codeclimate.com/github/shopkeep/mulder/badges/gpa.svg)](https://codeclimate.com/github/shopkeep/mulder)

## Installation

Add this line to your application's Gemfile:

    gem 'mulder'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mulder

## Usage

### CLI

To see the web servers for an app, and environment:

    mulder search banana_sandwich production WebServerGroup

Example output:

    [
        {
                        :id => "i-ididid",
                  :dns_name => "web.prod.example.com",
         :public_ip_address => "1.0.1.0",
        :private_ip_address => "0.1.0.1",
         :availability_zone => "us-east-1a",
                :created_at => 2013-08-08 18:21:05 UTC
        }
    ]

To change the configration file:

    mulder search banana_sandwich production WebServerGroup human foo.yml

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
