require 'spec_helper'

describe Mulder::Formats::Base do
  describe '.new' do
    it 'stores the instances' do
      described_class.new(['foo']).instances.should == ['foo']
    end
  end

  describe '#output' do
    it 'raises a NotImplementedError' do
      expect {
        described_class.new(['foo']).output
      }.to raise_error(NotImplementedError)
    end
  end
end