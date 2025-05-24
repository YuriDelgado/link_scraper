require "nokogiri"
require "open-uri"

class PageScraperService
  def initialize(page)
    @page = page
  end

  def call
    @page.processing!

    document = Nokogiri::HTML(URI.open(@page.url))
    @page.update(title: document.title)
    document.css("a[href]").each do |link|
      href = link["href"]
      name = link.inner_html.strip[0..80]
      @page.links.create(href: href, name: name)
    end

    @page.done!
  rescue
    @page.failed!
  end
end
