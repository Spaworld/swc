namespace :db do

  desc "finds and populates Channels, Orders, Orders and OrderDetails tables from stored CSVs"
  task parse_csvs: :environment do
    puts "all good"
  end

  def exectute_statement(sql)
    results = ActiveRecord::Base.connection.execute(sql)
    results.present? ? results : nil
  end

end
