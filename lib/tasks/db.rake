namespace :db do
  desc 'finds and populates data from remote db'
  task pull_orders: :environment do
    columns = [ENV['ORDERS_CUSTOMER_ID'], ENV['ORDERS_PRICE'], ENV['ORDERS_DATE'], ENV['ORDERS_ID']]
    table = ENV['ORDERS_TABLE_NAME']
    options = "WHERE #{ENV['ORDER_DETAILS_ORDERS_FOREIGN_KEY']} IN (#{ENV['SELECTED_CHANNELS']}) AND #{ENV['ORDERS_IS_RETURN']}=0"
    column_mappings = {
      ENV['ORDERS_ID']          => 'legacy_id',
      ENV['ORDERS_CUSTOMER_ID'] => 'channel_id',
      ENV['ORDERS_PRICE']       => 'total_price',
      ENV['ORDERS_DATE']        => 'placement_date'
    }
    datetime_of_the_last_update = Order.last.created_at
    RemoteDbConnector.generate_query(table, columns, options)
    RemoteDbConnector.execute_query(RemoteDbConnector.generated_query)
    return unless datetime_of_the_last_update < RemoteDbConnector.raw_results.last.ENV['ORDERS_DATE']
    RemoteDbConnector.map_column_names(RemoteDbConnector.raw_results, column_mappings)
    RemoteDbConnector.mapped_results.each do |hash|
      Order.create(hash)
    end
  end
end
