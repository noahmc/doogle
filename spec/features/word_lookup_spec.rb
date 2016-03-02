require 'rails_helper'
require 'nokogiri'

feature 'Word Lookup', js: true, type: :feature do
  let(:word) { 'test case' }
  let(:definition_1) { 'Definition 1' }
  let(:definition_2) { 'Definition 2' }
  let(:valid_response) { <<-XML }
  <entry_list>
    <entry>
      <ew>#{word}</ew>
      <def>
        <dt>#{definition_1}</dt>
        <dt>#{definition_2}</dt>
      </def>
    </entry>
  </entry_list>
  XML

  scenario 'A user looks up a word' do
    visit root_path

    stub_dictionary_api_request word, valid_response

    fill_in 'entry_word', with: word
    click_button 'Doogle Search'

    sleep 1

    expect(page).not_to have_selector('#error_message', text: 'No definition found')
    expect(page).to have_selector('ul li h4', text: word)
    expect(page).to have_selector('ul li', text: definition_1)
    expect(page).to have_selector('ul li', text: definition_2)
  end
end