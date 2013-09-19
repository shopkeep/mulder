require 'spec_helper'

describe Poirot::Connection do

  let(:config) { stub(aws_access_key_id: 'foo', aws_secret_access_key: 'bar') }
  let(:connection) { described_class.new(config) }

  describe ".new" do
    it 'stores the config' do
      connection.config.should == config
    end
  end

  describe "#autoscaler" do
    it 'initializes a Fog::AWS::AutoScaling' do
      Fog::AWS::AutoScaling.expects(:new)
      connection.autoscaler
    end

    it 'memoizes the initalized Fog::AWS::AutoScaling' do
      Fog::AWS::AutoScaling.expects(:new).once.returns(mock)
      2.times { connection.autoscaler }
    end
  end

  describe "#compute" do
    it 'initializes a Fog::Compute::AWS' do
      Fog::Compute::AWS.expects(:new)
      connection.compute
    end

    it 'memoizes the initalized Fog::Compute::AWS' do
      ::Fog::Compute::AWS.expects(:new).once.returns(mock)
      2.times { connection.compute }
    end
  end

  describe "#group_by_id_regexp" do
    it 'finds all of the groups whose id matches the regexp' do
      mocked_group  = mock(id: 'foo-bar')
      connection = described_class.new(config)
      connection.expects(:autoscaler).returns(mock(groups: [mocked_group]))

      connection.group_by_id_regexp(/foo-bar/).should == mocked_group
    end
  end

  describe "#instances_by_group" do
    it 'finds the instances for the group and returns Poirot::Instances' do
      mocked_instance = mock(id: 'foo')
      compute_instance = mock
      mocked_group = mock(instances: [mocked_instance])
      connection = described_class.new(config)
      connection.expects(:server_by_instance_id).with('foo').returns(compute_instance)
      Poirot::Instance.expects(:new).with(compute_instance)
      connection.instances_by_group(mocked_group)
    end
  end

  describe "#server_by_instance_id" do
    it 'finds the compute connections server by the given id' do
      mocked_compute  = mock
      mocked_servers  = mock

      connection = described_class.new(config)
      connection.expects(:compute).returns(mocked_compute)
      mocked_compute.expects(:servers).returns(mocked_servers)
      mocked_servers.expects(:get).with('foo').returns('bar')
      connection.server_by_instance_id('foo').should == 'bar'
    end
  end

end