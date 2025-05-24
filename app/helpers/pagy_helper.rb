module PagyHelper
  def pagy_turbo_nav(pagy)
    html = +""
    pagy.series.each do |item|
      case item
      when Integer
        html << link_to(item, url_for(page: item), class: "px-3 py-1 underline decoration-sky-300 text-blue-600 hover:bg-gray-100 hover:text-blue-300", data: { turbo_frame: "pages_table", turbo_preload: false })
      when String
        html << content_tag(:span, item, class: "px-3 py-1 text-gray-500")
      when Array
        html << link_to(item[0], url_for(page: item[0]), class: "px-3 py-1", data: { turbo_frame: "pages_table", turbo_preload: false })
      end
    end
    content_tag(:nav, html.html_safe, class: "flex gap-2 justify-center mt-4")
  end
end
