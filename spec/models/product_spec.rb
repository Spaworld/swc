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

    example 'empty legacy_id' do
      expect { create(:product, legacy_id: '') }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Legacy can\'t be blank')
    end
  end
end
