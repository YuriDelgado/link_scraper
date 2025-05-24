class PagesController < ApplicationController
  def index
    @pagy, @pages = pagy(Page.where(user: current_user).order(created_at: :desc), link_extra: 'data-turbo-frame="pages_table")')
    @page = Page.new

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show
    @page = Page.find(params[:id])
    @pagy, @links = pagy(@page.links)
  end

  def create
    @page = current_user.pages.build(page_params)

    if @page.save
      ScrapePageJob.perform_later(@page.id)

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
