class RemoteDbConnector < ActiveRecord::Base
  self.abstract_class = true

  class << self
    attr_accessor :raw_results, :mapped_results, :generated_query

    def generate_query(table, columns, options = '')
      # Generates a raw SQL query based on input:
      # -----------------------------------------
      # 'table'   :   table name    (string)
      # 'columns' :   columns names (array)
      # 'options' :   additional options passed
      #  as a string with raw SQL
      #  (e.g. "WHERE column_name IN (value(s))")

      table   = escape_sql(table)
      columns = columns.length > 1 ? columns.join(',') : escape_sql(columns)
      options = options.empty? ? ' ;' : " #{options} ;"
      @generated_query = "SELECT #{columns} FROM #{table}" + options
    end

    def execute_query(generated_query)
      return if generated_query.nil?
      connect_to_remote_db unless connected_to_remote_db? || ENV['DATABASE_PASSWORD'].nil?
      @raw_results = connection.select_all(generated_query)
    end

    def connect_to_remote_db
      establish_connection(:remote_db)
    end

    def connected_to_remote_db?
      connection_config.values[3] == ENV['DATABASE_NAME']
    end

    def escape_sql(value)
      send(:sanitize_sql_array, value)
    end

    def map_column_names(raw_results, column_mappings)
      return unless raw_results.first.keys.sort == column_mappings.keys.sort
      raw_results.map do |result|
        result.keys.each { |k| result[column_mappings [k]] = result.delete(k) }
      end
      @mapped_results = raw_results
    end

    def finds_new_records?(new_record, stored_record, new_record_date_key)
      if new_record.nil? || stored_record.nil?
        true
      elsif stored_record.created_at < new_record[new_record_date_key]
        true
      else
        false
      end
    end
  end
  private_class_method :connect_to_remote_db
end
