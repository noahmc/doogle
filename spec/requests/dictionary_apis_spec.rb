require 'rails_helper'

RSpec.describe "Dictionary Apis" do
  describe "GET word" do
    subject(:dictionary_api_webservice) { DictionaryWebService.get_definitions_for(word) }

    before do
      WebMock.allow_net_connect!
    end

    context 'with a proper definable word' do
      let(:word) { 'test' }

      it 'returns a payload with a list of entries' do
        response = dictionary_api_webservice
        xml_hash = Hash.from_xml(response.body)
        entry_hash = xml_hash['entry_list']['entry'].first

        expect(entry_hash.keys).to include('def', 'ew'), 'An entry should have a definition and word(ew)'
        expect(entry_hash['def'].keys).to include('dt'), 'A definition should have a dt'
      end
    end

    context 'with a a non-sensical word' do
      let(:word) { 'asdf' }

      it 'returns a payload with an empty list' do
        response = dictionary_api_webservice
        xml_hash = Hash.from_xml(response.body)
        expect(xml_hash['entry_list'].keys).not_to include('entry'), 'A non-found word should return a blank entry list'
      end
    end
  end
end
