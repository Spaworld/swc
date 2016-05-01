require 'rails_helper'

RSpec.describe OrderDetail, type: :model do
  it 'has a working factory' do
    expect(build(:order_detail)).to be_valid
  end

  describe 'validations' do
    it 'can be stored with valid attributes' do
      expect { create(:order_detail) }.to change(OrderDetail, :count).by(1)
    end
    context 'can\'t be stored with' do
      example 'empty order_id' do
        expect { create(:order_detail, order_id: '') }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Order can\'t be blank')
      end

      example 'empty product_id' do
        expect { create(:order_detail, product_id: '') }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Product can\'t be blank')
      end

      example 'empty quantity' do
        expect { create(:order_detail, quantity: '') }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Quantity can\'t be blank')
      end

      example '0 quantity' do
        expect { create(:order_detail, quantity: 0) }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Quantity must be greater than 0')
      end
    end
  end
end
