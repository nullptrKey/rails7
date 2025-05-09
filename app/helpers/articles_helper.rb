module ArticlesHelper
  def display_time(created_at, updated_at)
    content_tag(:small) do
      concat("Created ")
      concat(
        content_tag(:time, time_ago_in_words(created_at) + " ago", datetime: created_at.iso8601)
      )
      concat(", edited ")
      concat(
        content_tag(:time, time_ago_in_words(updated_at) + " ago", datetime: updated_at.iso8601, class: "text-muted")
      )
    end
  end
end
