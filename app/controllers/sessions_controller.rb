class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user
      if user.authenticate(params[:session][:password])
        sign_in user
        redirect_to user
      else
        flash.now[:danger] = "Invalid password."
        render 'new'
      end
    else
      flash.now[:danger] = "Invalid email."
      render 'new'
    end
  end

  def destroy
  end
end
