require 'rails_helper'

RSpec.describe Definition, type: :model do
  let(:definition) { Definition.new(description: 'test') }

  context 'validations' do
    it { is_expected.to validate_presence_of(:description) }
  end

  context 'associations' do
    it { is_expected.to belong_to(:entry) }
  end
end
