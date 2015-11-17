require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe '.average_rating' do
    let(:restaurant) { Restaurant.create! }
    subject { restaurant.average_rating }

    context 'with no ratings' do
      it { is_expected.to be nil }
    end

    context 'with one rating on one item' do
      let!(:item) { restaurant.items.create! }
      before { item.ratings.create!(value: 5) }

      it 'equals the one rating' do
        expect(subject).to eq 5
      end
    end

    context 'with many ratings on one item' do
      let!(:item) { restaurant.items.create! }

      before do
        item.ratings.create!(value: 5)
        item.ratings.create!(value: 4)
      end

      it 'equals the average of the ratings' do
        expect(subject).to eq 4.5
      end
    end

    context 'with many ratings on many items' do
      let!(:item_1) { restaurant.items.create! }
      let!(:item_2) { restaurant.items.create! }

      before do
        item_1.ratings.create!(value: 6)
        item_2.ratings.create!(value: 3)
        item_2.ratings.create!(value: 6)
      end

      it 'equals the average of all ratings' do
        expect(subject).to eq 5
      end
    end
  end
end
