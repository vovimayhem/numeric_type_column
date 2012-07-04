require 'active_record/connection_adapters/abstract_mysql_adapter'

::ActiveRecord::ConnectionAdapters::AbstractMysqlAdapter::NATIVE_DATABASE_TYPES[:primary_key] = 'INT UNSIGNED DEFAULT NULL auto_increment PRIMARY KEY'



module ActiveRecord

end

module NumericTypeColumn
  module AbstractMysqlAdpaterExtension
    def test_scream
      puts "Hello! #{native_database_types[:primary_key]}"
    end
  end
end
