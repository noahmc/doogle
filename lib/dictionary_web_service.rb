class DictionaryWebService
  BASE_URL = 'http://www.dictionaryapi.com/api/v1/references/collegiate/xml/'
  API_KEY_PARAM = "?key=#{Rails.application.secrets.dictionary_api}"

  def self.get_definitions_for(word)
    return nil unless word

    Faraday.get URI.parse(api_url(word))
  end

  private

  def self.api_url(word)
    url_word = URI.escape(word)
    BASE_URL + url_word + API_KEY_PARAM
  end
end