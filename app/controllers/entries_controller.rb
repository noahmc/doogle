require 'net/http'

class EntriesController < ApplicationController
  def create
    @entry = EntryFinder.locate(word_params[:word])

    if @entry.nil? || @entry.definitions.empty?
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

  def word_params
    params.require(:entry).permit(:word)
  end
end
