
def get_api_url(word)
  url_part = URI.escape(word) if word.present?
  "http://www.dictionaryapi.com/api/v1/references/collegiate/xml/#{url_part}?key=#{Rails.application.secrets.dictionary_api}"
end

def stub_dictionary_api_request(word, response)
  stub_request(:get, get_api_url(word)).
    to_return(status: 200, body: response, headers: {})
end

def expect_dictionary_api_requested(word, times = 1)
  assert_requested :get, get_api_url(word),
                   :times => times
end
