class StaticPagesController < ApplicationController
  def home
    @entry = Entry.new
    @error_message = "Other Message"
  end
end
