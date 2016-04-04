require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe '.average_rating' do
    let(:restaurant) { Restaurant.create! }
    subject { restaurant.average_rating }

    context 'with no ratings' do
      it { is_expected.to be nil }
    end

    context 'with one rating on one dish' do
      let!(:dish) { restaurant.dishes.create! }
      before { dish.ratings.create!(value: 5) }

      it 'equals the one rating' do
        expect(subject).to eq 5
      end
    end

    context 'with many ratings on one dish' do
      let!(:dish) { restaurant.dishes.create! }

      before do
        dish.ratings.create!(value: 5)
        dish.ratings.create!(value: 4)
      end

      it 'equals the average of the ratings' do
        expect(subject).to eq 4.5
      end
    end

    context 'with many ratings on many dishes' do
      let!(:dish_1) { restaurant.dishes.create! }
      let!(:dish_2) { restaurant.dishes.create! }

      before do
        dish_1.ratings.create!(value: 6)
        dish_2.ratings.create!(value: 3)
        dish_2.ratings.create!(value: 6)
      end

      it 'equals the average of all ratings' do
        expect(subject).to eq 5
      end
    end
  end
end
