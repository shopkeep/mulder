require 'json'

module Mulder
  class Instance

    attr_reader :fog_compute_instance

    def initialize(fog_compute_instance)
      @fog_compute_instance = fog_compute_instance
    end

    def id
      @fog_compute_instance.id
    end

    def dns_name
      @fog_compute_instance.dns_name
    end

    def public_ip_address
      @fog_compute_instance.public_ip_address
    end

    def private_ip_address
      @fog_compute_instance.private_ip_address
    end

    def vpc_id
      @fog_compute_instance.vpc_id
    end

    def created_at
      @fog_compute_instance.created_at
    end

    def as_hash
      @as_hash ||= {
        id: id,
        dns_name: dns_name,
        public_ip_address: public_ip_address,
        private_ip_address: private_ip_address,
        vpc_id: vpc_id,
        created_at: created_at
      }.delete_if { |_, value| value == '' || value == nil }
    end
  end
end