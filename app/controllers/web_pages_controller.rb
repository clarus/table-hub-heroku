class WebPagesController < ApplicationController
  def show
    @web_page = current_user.web_page
  end

  def edit
    @web_page = current_user.web_page
  end

  def update
    @web_page = WebPage.find(params[:id])
    if @web_page.update_attributes(web_page_params)
      flash[:success] = "Site mis à jour"
    end
    render 'edit'
  end

  private
    def web_page_params
      params.require(:web_page).permit(:title, :summary)
    end
end
