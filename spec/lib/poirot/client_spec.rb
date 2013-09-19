require 'spec_helper'

describe Poirot::Client do

  describe '.initialize' do
    let(:mocked_connection) { mock }

    it 'stores the app' do
      described_class.new(mocked_connection, 'foo', 'bar', 'worker').app.should == 'foo'
    end

    it 'stores the environment' do
      described_class.new(mocked_connection, 'foo', 'bar', 'worker').environment.should == 'bar'
    end
  end

  describe '#group' do
    it 'finds the correct group based on the given attributes' do
      mocked_connection = mock
      mocked_connection.expects(:group_by_id_regexp).with(/^foo-bar-WorkerGroup-.*$/i)
      client = described_class.new(mocked_connection, 'foo', 'bar', 'WorkerGroup')

      client.group
    end
  end

  describe '#instances' do
    it 'finds the instances for the group' do
      mocked_connection = mock
      mocked_group = mock
      mocked_connection.expects(:instances_by_group).with(mocked_group)
      client = described_class.new(mocked_connection, 'foo', 'bar', 'worker')
      client.expects(:group).returns(mocked_group)

      client.instances
    end
  end

end