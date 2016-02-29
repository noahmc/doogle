require 'net/http'

class EntriesController < ApplicationController
  def create
    word = word_params[:word]
    entry = Entry.find_by(word: word)

    if entry
      @definitions = entry.definitions.map { |definition| definition.description }
    else
      url = URI.parse(api_url(word_params[:word]))
      req = Net::HTTP::Get.new url.to_s
      res = Net::HTTP.start(url.host, url.port) { |http|
        http.request req
      }

      content = Nokogiri.XML(res.body)
      definitions = []
      content.xpath('//entry_list//entry//def//dt').each do |definition|
        definitions << definition.content
      end

      if definitions.any?
        entry = Entry.new(word: word)


        if entry.save
          definitions.each do |definition|
             entry.definitions.new(description: definition).save
          end
        end
      end

      @definitions = entry ? entry.definitions.map { |definition| definition.description } : definitions
    end



    if @definitions.empty?
      @error_message = "No definition found."
    end

    ajax_home_redirect
  end

  private
    def ajax_home_redirect
      respond_to do |format|
        format.html { redirect_to root_url }
        format.js
      end
    end

    def api_url(word)
      url_part = URI.escape(word)
      "http://www.dictionaryapi.com/api/v1/references/collegiate/xml/#{url_part}?key=#{Rails.application.secrets.dictionary_api}" if word
    end

    def word_params
      params.require(:entry).permit(:word)
    end
end
