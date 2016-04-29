require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'has a working factory' do
    expect(build(:product)).to be_valid
  end

  it 'can be stored with valid attributes' do
    expect { create(:product) }.to change(Product, :count).by 1
  end

  context 'cannot be stored with' do
    example 'empty name' do
      expect { create(:product, name: '') }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Name can\'t be blank')
    end

    example 'empty price in dollars' do
      expect { create(:product, price_in_dollars: '')}.to raise_error(ActiveRecord::RecordInvalid, 'Validation')
    end

    example 'invalid price in dollars' do
    end
  end
end
