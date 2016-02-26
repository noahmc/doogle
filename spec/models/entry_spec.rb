require 'rails_helper'

RSpec.describe Entry, type: :model do
  it 'should require a word' do
    entry = Entry.new(word: 'test')
    expect(entry.valid?).to be true
    entry.word = nil
    expect(entry.valid?).to be false
    entry.word = '   '
    expect(entry.valid?).to be false
  end

  it 'should not allow a word over 50 characters long' do
    entry = Entry.new(word: 'a' * 51)
    expect(entry.valid?).to be false
  end
end
