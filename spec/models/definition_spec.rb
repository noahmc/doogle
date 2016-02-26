require 'rails_helper'

RSpec.describe Definition, type: :model do
  it 'should require a description' do
    definition = Definition.new(description: 'test')
    expect(definition.valid?).to be true
    definition.description = nil
    expect(definition.valid?).to be false
    definition.description = '  '
    expect(definition.valid?).to be false
  end
end
