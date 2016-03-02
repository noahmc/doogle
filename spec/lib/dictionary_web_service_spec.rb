require 'rails_helper'

RSpec.describe DictionaryWebService do
  let(:expected_response) { '"kiwi":"bananas"'}

  context 'when a word is passed in' do
    let(:word) { 'boom' }

    before do
      stub_dictionary_api_request(word, expected_response)
    end

    it 'sends a request' do
      DictionaryWebService.get_definitions_for(word)

      expect_dictionary_api_requested(word)
    end

    it 'has a response' do
      response = DictionaryWebService.get_definitions_for(word)
      expect(response.body).to eq(expected_response)
    end
  end

  context 'when a word is not present' do
    let(:word) { nil }

    it 'does not send a request' do
      DictionaryWebService.get_definitions_for(word)

      expect_dictionary_api_requested(word, 0)
    end

    it 'has no response' do
      response = DictionaryWebService.get_definitions_for(word)

      expect(response).to be_nil
    end
  end

end