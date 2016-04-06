require 'rails_helper'

RSpec.describe Address, type: :model do
  describe '.parts_from_full' do
    subject { described_class.parts_from_full(full_address) }

    context 'with a standard, fully qualified address from google' do
      let(:full_address) { "1800 N Lincoln Ave, Chicago, IL 60614, United States" }

      it { is_expected.to eq({ address_1: "1800 N Lincoln Ave",
                               city:      "Chicago",
                               state:     "IL",
                               zip:       "60614" }) }
    end

    context 'with a period for an abbreviation in the street' do
      let(:full_address) { "12 S. Michigan Avenue, Chicago, IL 60603, United States" }

      it { is_expected.to eq({ address_1: "12 S. Michigan Avenue",
                               city:      "Chicago",
                               state:     "IL",
                               zip:       "60603" }) }
    end

    context 'with no country' do
      let(:full_address) { "12 S. Michigan Avenue, Chicago, IL 60603" }

      it { is_expected.to eq({ address_1: "12 S. Michigan Avenue",
                               city:      "Chicago",
                               state:     "IL",
                               zip:       "60603" }) }
    end

    context 'with no house number' do
      let(:full_address) { "O'Hare Airport, Chicago, IL 60666, United States" }

      it { is_expected.to eq({ address_1: "O'Hare Airport",
                               city:      "Chicago",
                               state:     "IL",
                               zip:       "60666" }) }
    end

    context 'with a multi-word city' do
      let(:full_address) { "1654 India St, San Diego, CA 92101, United States" }

      it { is_expected.to eq({ address_1: "1654 India St",
                               city:      "San Diego",
                               state:     "CA",
                               zip:       "92101" }) }
    end
  end
end
