class StaticPagesController < ApplicationController
  def home
    @user = User.new
  end

  def help
  end

  def contact
  end
end
