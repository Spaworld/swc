namespace :db do
  desc 'finds and populates data from remote db'
  task pull_orders: :environment do
    columns = [ENV['ORDERS_CUSTOMER_ID'], ENV['ORDERS_PRICE'], ENV['ORDERS_DATE'], ENV['ORDERS_ID']]
    table = ENV['ORDERS_TABLE_NAME']
    options = "WHERE #{ENV['ORDERS_CHANNEL_ID']} IN (#{ENV['SELECTED_CHANNELS']}) AND #{ENV['ORDERS_IS_RETURN']}=0"
    column_mappings = {
      ENV['ORDERS_ID']          => 'legacy_id',
      ENV['ORDERS_CUSTOMER_ID'] => 'channel_id',
      ENV['ORDERS_PRICE']       => 'price_in_dollars',
      ENV['ORDERS_DATE']        => 'placement_date'
    }
    RemoteDbConnector.generate_query(table, columns, options)
    RemoteDbConnector.execute_query(RemoteDbConnector.generated_query)
    RemoteDbConnector.map_column_names(RemoteDbConnector.raw_results, column_mappings)

    if RemoteDbConnector.finds_new_records?(RemoteDbConnector.mapped_results.last, Order.last, 'placement_date')
      RemoteDbConnector.mapped_results.each_with_index do |hash, index|
        Order.create(hash)
        puts "created record ##{index}"
      end
    else
      Rails.logger.info 'DB Connector: No new records found. Returning.'
    end
  end

  task pull_products: :environment do
    columnns = []
    tables = []
    options = ''
    column_mappings = {}
    RemoteDbConnector.generated_query(table, columns, options)
    RemoteDbConnector.execute_query(RemoteDbConnector.generated_query)
    RemoteDbConnector.map_column_names(RemoteDbConnector.raw_results, column_mappings)
    if RemoteDbConnector.finds_new_records?(RemoteDbConnector.mapped_results, Product.last, 'placement_date')
      RemoteDbConnector.mapped_results.each_with_index do |hash, index|
        Product.create(hash)
        puts "created order ##{index}"
      end
    else
      Rails.logger.info 'DB Connector: No new records found. Rturning'
    end
  end
end
