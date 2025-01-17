class Article::IndexSerializer < ActiveModel::Serializer
  attributes :id, :title, :teaser, :published, :category

  def published
    object.created_at.to_formatted_s(:long)
  end

  def category
    object.category.name.humanize
  end

  def teaser
    object.body[0, 60] + '...'
  end
end
