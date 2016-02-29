require 'rails_helper'

RSpec.describe EntriesController, type: :controller do
  fixtures :entries

  let(:blank_response) { "<entry_list></entry_list>" }
  let(:valid_response) {
    "<entry_list>
      <entry>
        <ew>Word</ew>
        <def>
          <dt>Definition</dt>
          <dt>Definition 2</dt>
        </def>
      </entry>
    </entry_list>"
  }

  context 'create' do
    it 'should retrieve an unknown word from the dictionary api and save it to the database' do
      word = "no test"

      expect(look_up word).to be_falsy
      stub_mock_request(word, valid_response)

      expect {
        post :create, entry: {word: word}
      }.to change { Entry.count }.by 1

      assert_mock_requested word

      expect(look_up word).to be_truthy
    end

    it 'should retrieve a known word from the database and not increase database entries count' do
      word = "test"

      expect(look_up word).to be_truthy
      stub_mock_request(word, valid_response)

      expect {
        post :create, entry: {word: word}
      }.not_to change {Entry.count} and not_to change {Definition.count}

      assert_mock_requested word, 0

      expect(look_up word).to be_truthy
    end

    it 'should not save an invalid word' do
      word = "asdf"

      stub_mock_request(word, blank_response)
      expect {
        post :create, entry: {word: word}
      }.not_to change {Entry.count}

      assert_mock_requested word

      expect(look_up word).to be_falsy
    end
  end

  def look_up(word)
    Entry.find_by(word: word)
  end
end
