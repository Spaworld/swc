require 'rails_helper'

describe RemoteDbConnector do
  let(:options)           { 'WHERE foo IN (bar,baz)' }
  let(:columns)           { FFaker::Lorem.words }
  let(:table)             { FFaker::Lorem.word }
  let(:generated_query)   { "SELECT #{columns.join(',')} FROM #{table} #{options} ;" }
  let(:raw_sql_results)   { [{ a: 1, b: 2, c: 3 }, { a: 4, b: 5, c: 6 }, { a: 7, b: 8, c: 9 }] }
  let(:column_mappings)   { { a: 'foo', b: 'bar', c: 'baz' } }
  let(:mapped_results)    { [{ 'foo' => 1, 'bar' => 2, 'baz' => 3 }, { 'foo' => 4, 'bar' => 5, 'baz' => 6 }, { 'foo' => 7, 'bar' => 8, 'baz' => 9 }] }
  let(:connection_config) { { :adapter => 'foo', :encoding => 'bar', :pool => 5, :database => 'baz'} }
  context 'connection to remote db' do
    it 'passes with valid data' do
      allow(RemoteDbConnector).to receive(:connection_config).and_return(connection_config)
      ENV['DATABASE_NAME'] = connection_config.values[3]
      expect(RemoteDbConnector.connected_to_remote_db?).to eq(true)
    end
    it 'fails with empty db name variable' do
      ENV['DATABASE_NAME'] = 'foo'
      expect(RemoteDbConnector.connected_to_remote_db?).to eq(false)
    end
  end
  context 'generates SQL query correctly' do
    example 'with the \'options\' string ' do
      RemoteDbConnector.generate_query(table, columns, options)
      expect(RemoteDbConnector.generated_query).to eq(
        "SELECT #{columns.join(',')} FROM #{table} #{options} ;"
      )
    end

    example 'without the \'options\' string' do
      RemoteDbConnector.generate_query(table, columns)
      expect(RemoteDbConnector.generated_query).to eq(
        "SELECT #{columns.join(',')} FROM #{table} ;"
      )
    end
  end
  context 'executes SQL query' do
    before(:each) do
      allow(RemoteDbConnector).to receive(:connected_to_remote_db?).and_return(true)
      allow(RemoteDbConnector.connection).to receive(:select_all).and_return(:raw_sql_results)
    end

    it 'sends the query to remote db' do
      connector = class_spy(RemoteDbConnector)
      RemoteDbConnector.execute_query(generated_query) do
        expect(connector.connection).to have_received(:select_all).once
      end
    end

    it 'returns raw SQL results' do
      RemoteDbConnector.execute_query(generated_query) do
        expect(RemoteDbConnector.raw_results).to eq(raw_sql_results)
      end
    end
  end

  it 'mapps db and attribute columns' do
    RemoteDbConnector.map_column_names(raw_sql_results, column_mappings)
    expect(RemoteDbConnector.mapped_results).to eq(mapped_results)
  end
end
