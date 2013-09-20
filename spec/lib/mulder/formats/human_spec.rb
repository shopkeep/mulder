require 'spec_helper'

describe Mulder::Formats::Human do

  describe '#output' do
    it 'calls ap with the correct stuff' do
      mocked_instances = mock(collect: [{ foo: :bar }])
      formatter = described_class.new(mocked_instances)
      formatter.expects(:ap).with([{ foo: :bar }], { index: false, sort: true })
      formatter.output
    end
  end

end