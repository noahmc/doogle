require 'rails_helper'

RSpec.describe EntriesController, type: :controller do
  fixtures :entries

  describe 'POST create' do
    def make_request
      post :create, { entry: { word: word } }
    end

    context 'when word is nil in the request' do
      let(:word) { nil }

      before do
        allow(EntryFinder).to receive(:locate).and_return(nil)
      end

      it 'returns the error message' do
        make_request

        expect(assigns(:error_message)).to eq("No definition found.")
      end
    end

    context 'when a word is present in the request' do
      let(:word) { 'cat' }
      let(:entry) { Entry.new(word: word) }

      it 'assigns entry' do
        expect(EntryFinder).to receive(:locate).with(word).and_return(entry)

        make_request

        expect(assigns(:entry)).to eq(entry)
      end
    end
  end
end
