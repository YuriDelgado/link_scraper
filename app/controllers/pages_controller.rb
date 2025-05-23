class PagesController < ApplicationController
  def index
    @pages = Page.where(user: current_user).order(created_at: :desc)
    @page = Page.new
  end

  def show
    @page = current_user.pages.find(params[:id])
    @links = @page.links
  end

  def create
    @page = current_user.pages.build(page_params)

    if @page.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to pages_path, notice: "Page added." }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("new_page", partial: "form", locals: { page: @page }) }
        format.html { render :new }
      end
    end
  end

  private

  def page_params
    params.require(:page).permit(:url)
  end
end
