require 'rails_helper'

describe RemoteDbConnector do
  let(:options)           { 'WHERE foo IN (bar,baz)' }
  let(:columns)           { FFaker::Lorem.words }
  let(:table)             { FFaker::Lorem.word }
  let(:generated_query)   { "SELECT #{columns.join(',')} FROM #{table} #{options} ;" }
  let(:raw_sql_results)   { { a: 1, b: 2, c: 3 } }

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
end
