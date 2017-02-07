require 'spec_helper_acceptance'
require_relative './version.rb'

describe 'logrotate class' do

  context 'custom dir setup' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOF

      class { 'logrotate':
        puppet_managed_dir => '/tmp/test_logrotate_dir_custom'
      }

      EOF

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end

    #/etc/logrotate.conf
    describe file($baseconf) do
      it { should be_file }
      its(:content) { should match 'include /tmp/test_logrotate_dir_custom' }
    end

    #/etc/logrotate.d/puppet-managed
    describe file('/tmp/test_logrotate_dir_custom') do
      it { should be_directory }
    end


  end

end
