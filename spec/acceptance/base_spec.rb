require 'spec_helper_acceptance'
require_relative './version.rb'

describe 'logrotate class' do

  context 'basic setup' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOF

      class { 'logrotate': }

      EOF

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end

    #/etc/logrotate.conf
    describe file($baseconf) do
      it { should be_file }
      its(:content) { should match 'puppet managed' }
      its(:content) { should match 'include /etc/logrotate.d/puppet-managed' }
      its(:content) { should match '# DO NOT CONFIGURE system-specific logs here' }
    end

  end

end
