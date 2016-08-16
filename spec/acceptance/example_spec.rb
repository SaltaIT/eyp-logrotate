require 'spec_helper_acceptance'
require_relative './version.rb'

describe 'logrotate class' do

  context 'example setup' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOF

      class { 'logrotate': }

      logrotate::logs { 'example':
        create_mode => '0777',
        rotate      => '3',
        log         => [ '/var/example/log1', '/var/example/log2' ],
      }

      logrotate::logs { 'bitban1':
        log           => '/deploy/VAR/local/elespanol/www.elespanol.com/BB3Logs/*log*',
        su            => [ 'bbt-deploy', 'bbt-deploy' ],
        rotate        => '2',
        frequency     => 'daily',
        notifempty    => true,
        compress      => true,
        delaycompress => true,
        missingok     => true,
      }

      logrotate::logs { 'rotatnginx':
        log        => '/LOGS/web/*.log',
        rotate     => '2',
        frequency  => 'daily',
        notifempty => true,
        compress   => true,
        missingok  => true,
        postrotate => '/etc/init.d/nginx reload',
      }

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

    describe file($example_nginx) do
      it { should be_file }
      its(:content) { should match 'rotate 2' }
      its(:content) { should match 'compress' }
      its(:content) { should_not match 'delaycompress' }
    end

    describe file($example_bitban) do
      it { should be_file }
      its(:content) { should match 'rotate 2' }
      its(:content) { should match 'compress' }
      its(:content) { should match 'delaycompress' }
    end

    describe file($example_demo) do
      it { should be_file }
      its(:content) { should match 'rotate 3' }
      its(:content) { should match 'create 0777 root root' }
    end

  end

end
