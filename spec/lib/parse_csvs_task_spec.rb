require 'rails_helper'

RSpec.describe 'db:parse_csvs', type: :rake do

  it { is_expected.to depend_on(:environment) }

  it 'finds csvs' do
    pending 'init'
  end

  it 'successfully parses and updates the Channels table' do
    pending 'init'
  end

  it 'successfully parses and updates the Orders table' do
    pending 'init'
  end

  it 'successfully parses and updates the OrderDetails table' do
    pending 'init'
  end

  it 'successfully parses and updates the Products table' do
    pending 'init'
  end

  it 'skips invalid records gracefully' do
    pending 'init'
  end

end
