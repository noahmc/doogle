require 'rails_helper'
require 'nokogiri'

feature 'Word Lookup', js: true, type: :feature do
  fixtures :entries
  fixtures :definitions

  let(:word) { "test case" }
  let(:valid_response) {
    "<entry_list>
      <entry>
        <ew>Test Case</ew>
        <def>
          <dt>Definition 1</dt>
          <dt>Definition 2</dt>
        </def>
      </entry>
    </entry_list>"
  }

  scenario 'A user looks up a word' do
    visit root_path

    stub_dictionary_api_request word, valid_response

    fill_in 'entry_word', with: word
    click_button 'Doogle Search'

    sleep 1

    expect(page).not_to have_selector('#error_message', text: 'No definition found')
    expect(page).to have_selector('ul li h4', text: word)
    expect(page).to have_selector('ul li', text: 'Definition 1')
    expect(page).to have_selector('ul li', text: 'Definition 2')
  end
end