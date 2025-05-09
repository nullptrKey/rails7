module ArticlesHelper
  def safe_content(text)
    simple_format(sanitize(text, tags: %w(strong em b i u p br a), attributes: %w(href)))
  end
end
