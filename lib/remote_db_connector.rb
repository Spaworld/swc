class RemoteDbConnector < ActiveRecord::Base

  self.abstract_class = true

  class << self
    attr_accessor :raw_results, :hashed_results, :generated_query

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
      options = options.empty? ? ';' : " #{options} ;"
      @generated_query = "SELECT #{columns} FROM #{table}" + options
    end

    def escape_sql(value)
      send(:sanitize_sql_array, value)
    end

  end

end
