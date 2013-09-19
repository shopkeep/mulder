require 'spec_helper'
require 'mulder/capistrano'

describe Mulder::Capistrano do

  describe '#client' do
    it 'instantiates a new client with the correct role' do
      mocked_connection = mock
      mocked_config = mock
      Mulder::Config.expects(:from).returns(mocked_config)
      Mulder::Connection.expects(:new).returns(mocked_connection)

      capistrano = described_class.new('foo', 'bar', 'widget')
      ::Mulder::Client.expects(:new).with(mocked_connection, 'bar', 'widget', 'ROLE')

      capistrano.client('ROLE')
    end
  end

  describe '.ips' do
    it 'it returns the public ips for the client' do
      mocked_connection = mock
      mocked_config = mock
      Mulder::Config.expects(:from).returns(mocked_config)
      Mulder::Connection.expects(:new).returns(mocked_connection)

      capistrano = described_class.new('foo', 'bar', 'widget')
      capistrano.expects(:client).with('bananas').returns(mock(instances: [mock(public_ip_address: 'foo')]))

      capistrano.ips('bananas').should == ['foo']
    end

    it 'returns the private ips for the client' do
      mocked_connection = mock
      mocked_config = mock
      Mulder::Config.expects(:from).returns(mocked_config)
      Mulder::Connection.expects(:new).returns(mocked_connection)

      capistrano = described_class.new('foo', 'bar', 'widget')
      capistrano.expects(:client).with('bananas').returns(mock(instances: [mock(private_ip_address: 'foo')]))

      capistrano.ips('bananas', true).should == ['foo']
    end
  end
end