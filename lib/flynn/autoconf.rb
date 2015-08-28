require "flynn/autoconf/version"

module Flynn
  module AutoConf
    def self.setup_postgres(key: 'DATABASE_URL')
      setup_database_url(ENV, key: key)
    end

    def self.setup_database_url(env, key: 'DATABASE_URL')
      return nil if env.include?(key)
      values = env.values_at(*%w(PGUSER PGPASSWORD PGHOST PGDATABASE))
      return nil if values.include?(nil)
      env[key] = 'postgres://%s:%s@%s/%s' % values
      nil
    end
  end
end
