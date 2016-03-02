require 'rails_helper'

RSpec.describe EntryFinder do
  describe '.locate' do
    context 'when passed a word' do
      let(:word) { 'cat' }
      let(:description_1) { 'furry mammal' }
      let(:description_2) { '66% of the internet' }
      let(:entry) { double('Entry', word: word) }

      context 'when the word is in our database' do
        it 'should return an entry' do
          expect(Entry).to receive(:find_by).with(word: word).and_return(entry)

          expect(described_class.locate(word)).to eq(entry)
        end
      end

      context 'when the word is not in our database' do
        let(:xml_response) { <<-XML }
<entry_list>
  <entry>
    <def>
      <dt>#{description_1}</dt>
      <dt>#{description_2}</dt>
    </def>
  </entry>
<entry_list>
XML

        let(:dictionary_response) { double('DictionaryResponse', body: xml_response) }

        before do
          expect(DictionaryWebService).to receive(:get_definitions_for).with(word).and_return(dictionary_response)
        end

        it 'should return an entry' do
          new_entry = described_class.locate(word)

          expect(new_entry.word).to eq(word)
          expect(new_entry.definitions.first.description).to eq(description_1)
          expect(new_entry.definitions.second.description).to eq(description_2)
        end
      end
    end

    context 'when not passed a word' do
      it 'should return nil' do
        expect(described_class.locate(nil)).to be_nil
      end
    end
  end
end