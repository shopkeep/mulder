require 'spec_helper'

describe Mulder::Formatter do
  describe '.initialize' do
    it 'raises an error of the format is not implemented' do
      expect {
        described_class.new([], 'foo')
      }.to raise_error(NotImplementedError, 'Formatting as foo has not been implemented!')
    end
  end

  describe "#output" do
    it 'sends the correct formatter the instances' do
      mock_instances = mock
      Mulder::Formats::Human.expects(:new).with(mock_instances).returns(mock(output: 'foo'))
      Mulder::Formatter.new(mock_instances, 'human').output
    end
  end
end