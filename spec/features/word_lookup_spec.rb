require 'rails_helper'

feature 'Word Lookup', type: :feature do
  fail_text = "No definition found."
  search_text = "Doogle Search"

  before(:example) {
    stub_request(:get, get_api_url("test")).
      with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
      to_return(status: 200, body: "stubbed response", headers: {})

  }

  scenario 'should successfully search for word' do
    visit '/'

    fill_in "Word", with: 'test'


    click_button search_text

    expect(page).not_to have_text(fail_text)
  end

  @javascript
  scenario 'should fail to search for a blank word' do
    visit '/'

    fill_in "entry_word", with: '  '
    click_button search_text

    assert_requested :get, get_api_url("test"),
                     :headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'},
                     :times => 1

    expect(page).to have_selector("#error_message", text: fail_text)
  end

  scenario 'should fail to search for a non-sense word' do
    visit '/'

    fill_in "entry_word", with: 'asdf'
    click_button search_text

    assert_requested :get, get_api_url("test"),
                     :headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'},
                     :times => 1

    expect(page).to have_selector("#error_message", text: fail_text)
  end

  def get_api_url(word)
    "http://www.dictionaryapi.com/api/v1/references/collegiate/xml/#{word}?key=#{Rails.application.secrets.dictionary_api}" if word
  end

end