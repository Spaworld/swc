namespace :db do
  desc 'finds and populates data from remote db'
  task pull_orders: :environment do
    columns = [ ENV['ORDERS_ID'], ENV['ORDERS_PRICE'], ENV['ORDERS_DATE'], ENV['ORDERS_ID']]
    table = ENV['ORDERS_TABLE_NAME']
    options = "WHERE #{ENV['ORDER_DETAILS_ORDERS_FOREIGN_KEY']} IN (#{ENV['SELECTED_CHANNELS']}) AND #{ENV['ORDERS_IS_RETURN']}=0"
    RemoteDbConnector.generate_query(table, columns, options)
    puts RemoteDbConnector.generated_query
  end
end


