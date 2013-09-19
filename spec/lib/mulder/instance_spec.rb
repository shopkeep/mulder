require 'spec_helper'

describe Mulder::Instance do

  let(:attributes) { { id: "i-f17bf19e", dns_name: 'foo.example.org', public_ip_address: '10.0.0.2', private_ip_address: '10.1.1.1', vpc_id: 'vpc-e9663d87', created_at: DateTime.parse('2013-09-10 19:39:26 UTC').to_s } }

  describe '.new' do
    it 'stores the fog computer instance' do
      fog_compute_instance = mock
      described_class.new(fog_compute_instance).fog_compute_instance.should == fog_compute_instance
    end
  end

  describe '#as_hash' do
    let(:instance) { mock(attributes) }

    it 'has the expected attributes' do
      described_class.new(instance).as_hash.should == attributes
    end

    it 'rejects blank values' do
      instance = mock(attributes.merge(id: ''))
      described_class.new(instance).as_hash.should ==
        attributes.reject { |key, _| key == :id }
    end

    it 'rejects nil values' do
      instance = mock(attributes.merge(id: nil))
      described_class.new(instance).as_hash.should ==
        attributes.reject { |key, _| key == :id }
    end
  end

end