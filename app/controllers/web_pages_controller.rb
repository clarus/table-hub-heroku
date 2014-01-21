class WebPagesController < ApplicationController
  def show
    @web_page = current_user.web_page
  end

  def edit
    @web_page = current_user.web_page
  end
end
