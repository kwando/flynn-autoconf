require 'spec_helper'

describe Flynn::AutoConf do
  describe :setup_database_url do
    let(:env){
      {
          'PGDATABASE' => 'mydatabase',
          'PGUSER' => 'username',
          'PGPASSWORD' => 'mypass',
          'PGHOST' => '89.233.231.11'
      }
    }

    it 'creates a url from env vars' do
      expect(Flynn::AutoConf.setup_database_url(env)).to be_nil
      expect(env).to include('DATABASE_URL')
      expect(env['DATABASE_URL']).to eq('postgres://username:mypass@89.233.231.11/mydatabase')
    end

    it 'does nothing if DATABASE_URL is already present' do
      env['DATABASE_URL'] = 'do not touch me'
      expect(Flynn::AutoConf.setup_database_url(env)).to be_nil
      expect(env).to include('DATABASE_URL')
      expect(env['DATABASE_URL']).to eq('do not touch me')
    end


    %w(PGUSER PGPASSWORD PGHOST PGDATABASE).each do |key|
      it "does not touch the env if #{key} is missing" do
        env.delete(key)
        Flynn::AutoConf.setup_database_url(env)
        expect(env).not_to include('DATABASE_URL')
      end
    end
  end
end