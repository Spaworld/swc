require 'rails_helper'

RSpec.describe Order, type: :model do
  it 'has a working factory' do
    expect(build(:order)).to be_valid
  end

  it 'can be stored with valid attributes' do
    expect { create(:order) }.to change(Order, :count).by(1)
  end

  context 'cannot be stored with' do
    example 'invalid channel_id' do
      expect { create(:order, channel_id: 123_87) }.to raise_error('Validation failed: Order must belong to a known channel')
    end

    example 'empty channel_id' do
      expect { create(:order, channel_id: nil) }.to raise_error('Validation failed: Channel can\'t be blank')
    end

    example 'empty legacy_id' do
      expect { create(:order, legacy_id: nil) }.to raise_error('Validation failed: Legacy can\'t be blank')
    end

    example 'empty price_in_dollars' do
      expect { create(:order, price_in_dollars: nil) }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Price in dollars can\'t be blank')
    end

    example '0 price_in_dollars' do
      expect { create(:order, price_in_dollars: 0) }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Price in dollars must be greater than 0')
    end

    example 'empty placement_date' do
      expect { create(:order, placement_date: nil) }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Placement date can\'t be blank')
    end
  end
end
