require 'net/http'

class EntriesController < ApplicationController
  def create
    url = URI.parse(api_url("test"))
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }

    @content = res.body

    @error_message = "No definition found."

    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  private
    def api_url(word)
      "http://www.dictionaryapi.com/api/v1/references/collegiate/xml/#{word}?key=#{Rails.application.secrets.dictionary_api}" if word
    end
end
