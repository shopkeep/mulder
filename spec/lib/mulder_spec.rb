require 'spec_helper'

describe Mulder do

  describe '.search' do
    it 'uses the human formatter for the given params' do
      mock_config = mock
      Mulder::Config.expects(:from).with(:yaml, file: 'config/aws.yml').returns(mock_config)

      mock_connection = stub
      Mulder::Connection.expects(:new).with(mock_config).returns(mock_connection)

      mock_client = stub
      Mulder::Client.expects(:new).with(mock_connection, 'foo-app', 'production', 'WebServerGroup').returns(mock_client)

      mock_instances = stub
      mock_client.expects(:instances).returns(['foo'])

      mocked_formatter = stub
      Mulder::Formatter.expects(:new).with(['foo'], 'human').returns(mocked_formatter)

      mocked_formatter.expects(:output).once
      described_class.search('foo-app', 'production', 'WebServerGroup', 'human', 'config/aws.yml')
    end
  end

end