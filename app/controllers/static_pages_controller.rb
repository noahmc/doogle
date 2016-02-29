class StaticPagesController < ApplicationController
  def home
    @entry = Entry.new
  end
end
