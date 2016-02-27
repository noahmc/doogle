require 'rails_helper'
require 'nokogiri'

feature 'Word Lookup', js: true, type: :feature do
  let(:fail_text) { "No definition found" }
  let(:search_text) { "Doogle Search" }
  let(:word_input_id) { "entry_word" }
  let(:error_message_selector) { "#error_message" }
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

  scenario 'should successfully search for word' do
    word = 'test'

    stub_mock_request word, valid_response
    visit root_path
    fill_in word_input_id, with: word
    click_button search_text

    #allow request to have time to be made
    sleep 1

    assert_mock_requested word

    expect(page).not_to have_selector(error_message_selector, text: fail_text)
    expect(page).to have_selector("ul li")
  end

  scenario 'should fail to search for a non-sense word' do
    word = 'asdf'

    stub_mock_request word, blank_response
    visit root_path

    fill_in word_input_id, with: word
    click_button search_text

    assert_mock_requested word

    expect(page).to have_selector(error_message_selector, text: fail_text)
    expect(page).not_to have_selector("ul li")
  end



end