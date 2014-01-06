class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user
      if user.authenticate(params[:session][:password])
        sign_in user
        redirect_back_or user
      else
        flash.now[:danger] = "Mot de passe invalide."
        render 'new'
      end
    else
      flash.now[:danger] = "Email invalide."
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
