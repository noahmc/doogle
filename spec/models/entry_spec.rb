require 'rails_helper'

RSpec.describe Entry, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:word) }
    it { is_expected.to validate_length_of(:word).is_at_most(50) }
  end

  context 'associations' do
    it { is_expected.to have_many(:definitions) }
  end
end
