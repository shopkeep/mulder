require 'spec_helper'

describe Mulder::Formats::JSON do

  describe '#stream' do
    it 'defaults to STDOUT' do
      formatter = described_class.new(anything)
      expect(formatter.stream).to eq(STDOUT)
    end

    it 'returns the given stream' do
      io = mock()
      formatter = described_class.new(anything)
      formatter.stream = io

      expect(formatter.stream).to eq(io)
    end
  end

  describe '#output' do
    it 'prints json encoded output to the stream' do
      instances = [{ foo: :bar }]
      mocked_instances = mock(collect: instances)

      io = StringIO.new()
      formatter = described_class.new(mocked_instances)
      formatter.stream = io

      formatter.output
      expect(io.string).to eq('[{"foo":"bar"}]')
    end
  end

end
