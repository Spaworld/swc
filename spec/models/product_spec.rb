require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'has a working factory' do
    expect(build(:product)).to be_valid
  end

  describe 'validations' do
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

  describe 'associations' do
    it 'is associated with orders' do
      expect(subject).to respond_to(:orders)
    end

    let(:product) { create(:product) }
    let(:order_detail) { build(:order_detail, product_id: product.id) }

    it 'has_many orders through order_details' do
      expect(order_detail.product).to eq product
    end
  end
end
