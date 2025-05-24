class ScrapePageJob < ApplicationJob
  queue_as :default

  def perform(page_id)
    page = Page.find(page_id)
    PageScraperService.new(page).call
  end
end
