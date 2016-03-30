require 'rails_helper'

describe RemoteDbConnector do
  context 'generates SQL query correctly :' do
    let(:options)     { 'WHERE foo IN bar' }
    let(:columns)     { FFaker::Lorem.words }
    let(:table)       { FFaker::Lorem.word }
    it 'with <options> string ' do
      RemoteDbConnector.generate_query(table, columns, options)
      expect(RemoteDbConnector.generated_query).to eq(
        "SELECT #{columns.join(',')} FROM #{table} #{options} ;"
      )
    end
    it 'without the \'options\' string' do
      RemoteDbConnector.generate_query(table, columns)
      expect(RemoteDbConnector.generated_query).to eq(
        "SELECT #{columns.join(',')} FROM #{table} ;"
      )
    end
  end
end
